#!/usr/bin/env bash
# Shared helpers for the setup scripts. Source it, don't execute it:
#
#   source "$DOTFILES/setups/lib/common.sh"
#   parse_flags "$@"; start_logging
#   run_step <name> <function>   # repeat per step
#   summary                      # ✔/✘ table, returns 1 if any step failed
# shellcheck disable=SC2034

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
SETUP_LOG="${SETUP_LOG:-$HOME/.dotfiles-setup.log}"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# ── flags ────────────────────────────────────────────────────────────────────
OPT_ONLY=""
OPT_SKIP=""
OPT_APPS=""   # "", "yes" or "no"
OPT_YES=0
OPT_LIST=""

usage() {
	cat <<EOF
Usage: install.sh [options]

  --only a,b     run only these steps
  --skip a,b     skip these steps
  --apps         also install Brewfile.apps (GUI apps)
  --no-apps      never install Brewfile.apps
  --yes, -y      no prompts (implies --no-apps unless --apps is given)
  --list         list the available steps
  --help, -h     this help
EOF
}

parse_flags() {
	while [[ $# -gt 0 ]]; do
		case "$1" in
		--only) OPT_ONLY="$2"; shift ;;
		--only=*) OPT_ONLY="${1#*=}" ;;
		--skip) OPT_SKIP="$2"; shift ;;
		--skip=*) OPT_SKIP="${1#*=}" ;;
		--apps) OPT_APPS="yes" ;;
		--no-apps) OPT_APPS="no" ;;
		--yes | -y) OPT_YES=1 ;;
		--list) OPT_LIST=1 ;;
		--help | -h) usage; exit 0 ;;
		*) err "unknown option: $1"; usage; exit 1 ;;
		esac
		shift
	done
}

# ── logging ──────────────────────────────────────────────────────────────────
if [[ -t 1 ]]; then
	C_RESET=$'\e[0m' C_BLUE=$'\e[34m' C_GREEN=$'\e[32m' C_YELLOW=$'\e[33m' C_RED=$'\e[31m' C_BOLD=$'\e[1m'
else
	C_RESET="" C_BLUE="" C_GREEN="" C_YELLOW="" C_RED="" C_BOLD=""
fi

info() { printf '%s[INFO]%s %s\n' "$C_BLUE" "$C_RESET" "$*"; }
ok() { printf '%s[ OK ]%s %s\n' "$C_GREEN" "$C_RESET" "$*"; }
warn() { printf '%s[WARN]%s %s\n' "$C_YELLOW" "$C_RESET" "$*" >&2; }
err() { printf '%s[FAIL]%s %s\n' "$C_RED" "$C_RESET" "$*" >&2; }

# Mirror everything to the log file. Interactive commands must use `tty_run`,
# because after this stdout/stderr are a pipe, not a terminal.
start_logging() {
	printf '\n===== %s =====\n' "$(date)" >>"$SETUP_LOG"
	exec > >(tee -a "$SETUP_LOG") 2>&1
}

# Run a command attached to the real terminal (gh auth login, prompts, ...).
tty_run() {
	if [[ -r /dev/tty && -w /dev/tty ]]; then
		"$@" </dev/tty >/dev/tty 2>/dev/tty
	else
		"$@"
	fi
}

# ask "question" → 0 for yes. Defaults to no when --yes or there is no terminal.
ask() {
	local reply
	[[ $OPT_YES -eq 1 ]] && return 1
	[[ -r /dev/tty ]] || return 1
	printf '%s[ ?? ]%s %s (y/N) ' "$C_BOLD" "$C_RESET" "$1" >/dev/tty
	read -r reply </dev/tty
	[[ $reply =~ ^[Yy]$ ]]
}

# ── steps ────────────────────────────────────────────────────────────────────
declare -a STEP_NAMES=()
declare -a STEP_RESULTS=()

_in_list() { [[ ",$2," == *",$1,"* ]]; }

# run_step <name> <function>: runs it, records the result, never aborts the script.
# A function returning 99 is reported as skipped.
run_step() {
	local name="$1" fn="$2" status
	if [[ -n $OPT_ONLY ]] && ! _in_list "$name" "$OPT_ONLY"; then
		return 0
	fi
	if [[ -n $OPT_SKIP ]] && _in_list "$name" "$OPT_SKIP"; then
		STEP_NAMES+=("$name") STEP_RESULTS+=("skipped")
		return 0
	fi

	printf '\n%s━━ %s ━━%s\n' "$C_BOLD" "$name" "$C_RESET"
	"$fn"
	status=$?
	STEP_NAMES+=("$name")
	if [[ $status -eq 0 ]]; then
		STEP_RESULTS+=("ok")
		ok "$name"
	elif [[ $status -eq 99 ]]; then
		STEP_RESULTS+=("skipped")
	else
		STEP_RESULTS+=("failed ($status)")
		err "$name (exit $status) — see $SETUP_LOG"
	fi
	return 0
}

summary() {
	local i failed=0 result
	printf '\n%s━━ summary ━━%s\n' "$C_BOLD" "$C_RESET"
	for i in "${!STEP_NAMES[@]}"; do
		result="${STEP_RESULTS[$i]}"
		case "$result" in
		ok) printf '  %s✔%s %s\n' "$C_GREEN" "$C_RESET" "${STEP_NAMES[$i]}" ;;
		skipped) printf '  %s-%s %s (skipped)\n' "$C_YELLOW" "$C_RESET" "${STEP_NAMES[$i]}" ;;
		*) printf '  %s✘%s %s %s\n' "$C_RED" "$C_RESET" "${STEP_NAMES[$i]}" "$result"; failed=1 ;;
		esac
	done
	printf '\nlog: %s\n' "$SETUP_LOG"
	[[ -d $BACKUP_DIR ]] && printf 'backups: %s\n' "$BACKUP_DIR"
	return $failed
}

# ── misc helpers ─────────────────────────────────────────────────────────────
has() { command -v "$1" >/dev/null 2>&1; }

# append_once <line> <file>: appends only if the exact line isn't there yet.
append_once() {
	local line="$1" file="$2"
	mkdir -p "$(dirname "$file")"
	touch "$file"
	grep -qxF -- "$line" "$file" || printf '%s\n' "$line" >>"$file"
}

# Clone if missing, otherwise leave it alone (callers decide whether to pull).
git_clone_once() {
	local url="$1" dest="$2"
	shift 2
	[[ -d "$dest/.git" ]] && return 0
	git clone "$@" "$url" "$dest"
}

# backup_conflicts <stow-pkg>: moves files that would block `stow` to
# $BACKUP_DIR (keeping their relative path). Things that already resolve to the
# repo file (stow links, folded dirs) are left alone; hand-made absolute links
# to the repo are removed, since stow refuses to own them and will recreate them.
backup_conflicts() {
	local pkg="$1" rel target src
	while IFS= read -r rel; do
		rel="${rel#./}"
		target="$HOME/$rel"
		src="$DOTFILES/$pkg/$rel"
		if [[ -L $target && "$(readlink "$target")" == /* && $target -ef $src ]]; then
			rm "$target"
			continue
		fi
		[[ -e $target || -L $target ]] || continue
		[[ $target -ef $src ]] && continue
		mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
		mv "$target" "$BACKUP_DIR/$rel"
		warn "moved existing ~/$rel to $BACKUP_DIR/$rel"
	done < <(cd "$DOTFILES/$pkg" && find . \( -type f -o -type l \) ! -name .DS_Store)
}
