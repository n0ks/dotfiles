#!/usr/bin/env bash
# macOS setup. Every step is idempotent: re-running only fills in what's missing.
# A failing step is reported in the summary instead of aborting the run.
# Output is mirrored to ~/.dotfiles-setup.log; files that would block stow are
# moved to ~/.dotfiles-backup/<timestamp>/.
#
#   ./install.sh [--apps|--no-apps] [--yes] [--only a,b] [--skip a,b] [--list]
#
# Examples (from ~/.dotfiles; calling this script directly works the same):
#   ./install.sh                              # full run, prompts for GUI apps and reboot
#   ./install.sh --yes                        # no prompts, skips GUI apps and gh login
#   ./install.sh --apps --yes                 # no prompts, GUI apps included
#   ./install.sh --list                       # show the step names
#   ./install.sh --only dotfiles              # just re-stow the dotfiles
#   ./install.sh --only brew_bundle,brew_apps # sync the Brewfiles
#   ./install.sh --only ssh,github            # ssh key + gh login + private submodule
#   ./install.sh --skip neovim,macos_defaults # everything except these
#   NVIM_REF=v0.12.5 ./install.sh --only neovim   # build a specific neovim tag/branch
#
# Env overrides: NVIM_REF (default stable), NVIM_SRC (default ~/code/neovim).
#
# To run a single step function without the sudo preflight (debugging):
#   bash -c 'source setups/mac/mac-setup.sh; OPT_YES=1; run_step fonts step_fonts; summary'
# shellcheck source-path=SCRIPTDIR/../..
# shellcheck disable=SC2317 # step_* functions are called indirectly via run_step

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
export DOTFILES
# shellcheck source=setups/lib/common.sh
source "$DOTFILES/setups/lib/common.sh"

set -o allexport
# shellcheck source=.env
source "$DOTFILES/.env"
set +o allexport

NVIM_REF="${NVIM_REF:-stable}"
NVIM_SRC="${NVIM_SRC:-$HOME/code/neovim}"
SKIPPED=99 # step return code meaning "nothing done on purpose"

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

load_brew_env() {
	if [[ -x /opt/homebrew/bin/brew ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	elif [[ -x /usr/local/bin/brew ]]; then
		eval "$(/usr/local/bin/brew shellenv)"
	fi
}

# ── steps ────────────────────────────────────────────────────────────────────

step_xcode_clt() {
	if xcode-select -p >/dev/null 2>&1; then
		info "Command Line Tools already at $(xcode-select -p)"
	else
		local marker=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress label
		touch "$marker"
		label="$(softwareupdate -l 2>/dev/null |
			sed -n 's/^[[:space:]]*\* Label: \(Command Line Tools.*\)$/\1/p' | sort -V | tail -n1)"
		[[ -n $label ]] && sudo softwareupdate -i "$label" --verbose
		rm -f "$marker"
		if ! xcode-select -p >/dev/null 2>&1; then
			warn "headless install failed, opening the GUI installer — this step waits for it"
			xcode-select --install >/dev/null 2>&1
			until xcode-select -p >/dev/null 2>&1; do sleep 10; done
		fi
	fi

	if [[ "$(uname -m)" == "arm64" ]] && ! /usr/bin/pgrep -q oahd; then
		info "installing Rosetta 2"
		softwareupdate --install-rosetta --agree-to-license || return 1
	fi
}

step_homebrew() {
	load_brew_env
	if ! has brew; then
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || return 1
		load_brew_env
	fi
	# shellcheck disable=SC2016
	append_once 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile"
	brew update
}

# Homebrew 6 refuses to load formulae from third-party taps until they are trusted.
trust_taps() {
	local tap
	while read -r tap; do
		brew trust --tap "$tap" >/dev/null || return 1
	done < <(sed -n 's/^tap "\([^"]*\)".*/\1/p' "$1")
}

step_brew_bundle() {
	has brew || return 1
	trust_taps "$DOTFILES/Brewfile" || return 1
	HOMEBREW_NO_INSTALL_CLEANUP=1 brew bundle --no-upgrade --file="$DOTFILES/Brewfile"
}

step_brew_apps() {
	has brew || return 1
	if [[ -z $OPT_APPS ]]; then
		ask "Install the GUI apps from Brewfile.apps?" && OPT_APPS=yes || OPT_APPS=no
	fi
	if [[ $OPT_APPS != yes ]]; then
		info "skipping Brewfile.apps (use --apps)"
		return "$SKIPPED"
	fi
	HOMEBREW_NO_INSTALL_CLEANUP=1 brew bundle --no-upgrade --file="$DOTFILES/Brewfile.apps"
}

# The `private` submodule is a private repo: only possible once gh is logged in.
init_private() {
	[[ -e "$DOTFILES/private/.git" ]] && return 0
	if ! has gh || ! gh auth status >/dev/null 2>&1; then
		warn "gh not authenticated — 'private' submodule left for the github step"
		return 0
	fi
	gh auth setup-git >/dev/null 2>&1
	git -C "$DOTFILES" submodule update --init private
}

step_dotfiles() {
	has stow || { err "stow missing (brew_bundle failed?)"; return 1; }
	local pkg rc=0
	mkdir -p "$HOME/.config" # never let stow fold all of ~/.config into one package
	for pkg in $STOW_FOLDERS_MAC; do
		[[ -d "$DOTFILES/$pkg" ]] || { warn "no package '$pkg'"; continue; }
		backup_conflicts "$pkg"
		if stow -R --ignore='\.DS_Store' -d "$DOTFILES" -t "$HOME" "$pkg"; then
			info "stowed $pkg"
		else
			err "stow $pkg"
			rc=1
		fi
	done
	init_private || rc=1
	return "$rc"
}

step_fonts() {
	local font dest="$HOME/Library/Fonts"
	mkdir -p "$dest"
	for font in "$DOTFILES"/fonts/.local/share/fonts/*.ttf; do
		[[ -f "$dest/$(basename "$font")" ]] || cp "$font" "$dest/"
	done
}

step_shell() {
	# zsh-autosuggestions, pure, fzf and zoxide come from the Brewfile
	local local_rc="$HOME/.zshrc.local"
	if [[ ! -f $local_rc ]]; then
		cat >"$local_rc" <<'EOF'
# Machine-local secrets and overrides, sourced at the end of ~/.zshrc.
# Not versioned. Keep it chmod 600.

# export PAT_TOKEN=
# export HEADER_VALUE=$(echo -n "Authorization: Basic "$(printf ":%s" "$PAT_TOKEN" | base64))
# export MYSQL_PWD=
EOF
		info "created $local_rc"
	fi
	chmod 600 "$local_rc"

	if [[ "$(dscl . -read "$HOME" UserShell | awk '{print $2}')" != */zsh ]]; then
		sudo chsh -s /bin/zsh "$USER"
	fi
}

step_tmux() {
	git_clone_once https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" --depth 1 || return 1
	"$HOME/.tmux/plugins/tpm/bin/install_plugins"
}

step_runtimes() {
	has asdf || { err "asdf missing (brew_bundle failed?)"; return 1; }
	local plugin rc=0 installed
	installed="$(asdf plugin list 2>/dev/null)"
	for plugin in nodejs python golang java; do
		grep -qx "$plugin" <<<"$installed" || asdf plugin add "$plugin" || rc=1
	done
	# reads ~/.tool-versions (stowed from zsh/.tool-versions); skips what's installed
	(cd "$HOME" && asdf install) || rc=1
	return "$rc"
}

step_neovim() {
	local want have
	git_clone_once https://github.com/neovim/neovim.git "$NVIM_SRC" || return 1
	git -C "$NVIM_SRC" fetch --tags --force --quiet origin || return 1

	want="$(git -C "$NVIM_SRC" describe --tags --exact-match --exclude stable --exclude nightly "$NVIM_REF" 2>/dev/null)"
	have="$(nvim --version 2>/dev/null | head -n1 | awk '{print $2}')"

	if [[ -n $want && $have == "$want" ]]; then
		info "nvim $have already matches $NVIM_REF"
	else
		info "building nvim $NVIM_REF (have: ${have:-none})"
		(
			cd "$NVIM_SRC" &&
				git checkout --force "$NVIM_REF" &&
				{ git symbolic-ref -q HEAD >/dev/null && git pull --ff-only || true; } &&
				make distclean &&
				make CMAKE_BUILD_TYPE=Release &&
				sudo make install
		) || return 1
	fi

	info "syncing plugins (lazy-lock.json) and mason tools"
	nvim --headless "+Lazy! restore" +qa || return 1
	nvim --headless "+Lazy! load mason-tool-installer.nvim" "+MasonToolsInstallSync" +qa
}

step_extras() {
	local rc=0
	if ! has rustup; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path || rc=1
	fi
	if ! has uv; then
		curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh || rc=1
	fi
	if ! has claude; then
		curl -fsSL https://claude.ai/install.sh | bash || rc=1
	fi
	if has uv && ! uv tool list 2>/dev/null | grep -q '^graphifyy '; then
		uv tool install graphifyy || rc=1
	fi
	if has fvm && [[ -z "$(ls -A "${FVM_CACHE_PATH:-$HOME/fvm}/versions" 2>/dev/null)" ]]; then
		if ask "Install Flutter stable with fvm (~1.5GB)?"; then
			fvm install stable || rc=1
		fi
	fi
	return "$rc"
}

step_ssh() {
	local key="$HOME/.ssh/id_ed25519" email config="$HOME/.ssh/config"
	mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
	if [[ ! -f $key ]]; then
		email="$(git config --file "$DOTFILES/zsh/.gitconfig" user.email)"
		ssh-keygen -t ed25519 -C "${email:-$USER@$(hostname -s)}" -N "" -f "$key" || return 1
	fi
	ssh-add --apple-use-keychain "$key" 2>/dev/null || warn "ssh-agent not reachable, key not added"

	touch "$config" && chmod 600 "$config"
	if ! grep -q '^[[:space:]]*UseKeychain yes' "$config"; then
		printf '\nHost *\n  AddKeysToAgent yes\n  UseKeychain yes\n  IdentityFile ~/.ssh/id_ed25519\n' >>"$config"
	fi
}

step_github() {
	has gh || return 1
	if ! gh auth status >/dev/null 2>&1; then
		if [[ $OPT_YES -eq 1 || ! -r /dev/tty ]]; then
			warn "not logged in to GitHub; run 'gh auth login' and re-run with --only github"
			return "$SKIPPED"
		fi
		tty_run gh auth login --hostname github.com --git-protocol ssh --web --skip-ssh-key \
			--scopes admin:public_key || return 1
	fi

	local pub="$HOME/.ssh/id_ed25519.pub"
	if [[ -f $pub ]]; then
		if gh api user/keys --jq '.[].key' 2>/dev/null | grep -qF "$(awk '{print $2}' "$pub")"; then
			info "ssh key already on GitHub"
		else
			gh ssh-key add "$pub" --title "$(scutil --get ComputerName 2>/dev/null || hostname -s)" ||
				warn "could not upload the key (missing admin:public_key? run: gh auth refresh -s admin:public_key)"
		fi
	fi
	init_private
}

step_macos_defaults() {
	bash "$DOTFILES/setups/mac/macos-defaults.sh"
}

step_touchid_sudo() {
	local f=/etc/pam.d/sudo_local reattach
	reattach="$(brew --prefix 2>/dev/null)/lib/pam/pam_reattach.so"
	if [[ -f $f ]] && grep -q '^auth.*pam_tid.so' "$f"; then
		info "Touch ID for sudo already enabled"
		return 0
	fi
	{
		echo "# sudo_local: survives macOS updates. Generated by ~/.dotfiles setup."
		# pam_reattach makes Touch ID work inside tmux
		[[ -f $reattach ]] && echo "auth       optional       $reattach ignore_ssh"
		echo "auth       sufficient     pam_tid.so"
	} | sudo tee "$f" >/dev/null
}

STEPS=(
	"xcode_clt step_xcode_clt"
	"homebrew step_homebrew"
	"brew_bundle step_brew_bundle"
	"brew_apps step_brew_apps"
	"dotfiles step_dotfiles"
	"fonts step_fonts"
	"shell step_shell"
	"tmux step_tmux"
	"runtimes step_runtimes"
	"neovim step_neovim"
	"extras step_extras"
	"ssh step_ssh"
	"github step_github"
	"macos_defaults step_macos_defaults"
	"touchid_sudo step_touchid_sudo"
)

# ── main ─────────────────────────────────────────────────────────────────────

main() {
	parse_flags "$@"
	if [[ -n $OPT_LIST ]]; then
		printf '%s\n' "${STEPS[@]%% *}"
		exit 0
	fi
	[[ $OPT_YES -eq 1 && -z $OPT_APPS ]] && OPT_APPS=no

	start_logging
	info "Hello $(whoami)! Setting up $(scutil --get ComputerName 2>/dev/null) from $DOTFILES"
	[[ "$(uname -m)" == "arm64" ]] || warn "not Apple Silicon — paths assume /opt/homebrew"

	if [[ $OPT_YES -ne 1 ]] && [[ -r /dev/tty ]]; then
		ask "Setup is about to start. Continue?" || exit 0
	fi

	info "admin password (kept alive until the end)"
	sudo -v || exit 1
	while true; do
		sudo -n true </dev/null
		sleep 60
		kill -0 "$$" || exit
	done 2>/dev/null &
	caffeinate -dimsu -w $$ &

	load_brew_env

	local entry
	for entry in "${STEPS[@]}"; do
		run_step "${entry%% *}" "${entry##* }"
		[[ ${entry%% *} == homebrew ]] && load_brew_env
	done

	summary
	local rc=$?

	if [[ -z $OPT_ONLY ]] && ask "Reboot now so every setting applies?"; then
		sudo shutdown -r now
	fi
	exit $rc
}

# sourceable (for testing single steps) without running anything
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"
