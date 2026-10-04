#!/usr/bin/env bash
# Fresh-Mac entry point. Run it from Terminal.app on a just-formatted Mac:
#
#   curl -fsSL https://raw.githubusercontent.com/n0ks/dotfiles/master/bootstrap.sh | bash
#
# Flags after `bash -s --` are passed through to install.sh (see mac-setup.sh):
#
#   # also install the GUI apps (Brewfile.apps)
#   curl -fsSL https://raw.githubusercontent.com/n0ks/dotfiles/master/bootstrap.sh | bash -s -- --apps
#   # unattended: no prompts, GUI apps included
#   curl -fsSL https://raw.githubusercontent.com/n0ks/dotfiles/master/bootstrap.sh | bash -s -- --apps --yes
#
# Env overrides: DOTFILES (clone dir, default ~/.dotfiles), DOTFILES_REPO, DOTFILES_BRANCH.
#
# Installs the Xcode Command Line Tools and Homebrew (so `git` works), clones
# the repo into ~/.dotfiles and hands over to ./install.sh with the same flags.
# Asks for the admin password once at the start.

set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/n0ks/dotfiles.git}"
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
BRANCH="${DOTFILES_BRANCH:-master}"

info() { printf '\e[34m[INFO]\e[0m %s\n' "$*"; }
die() { printf '\e[31m[FAIL]\e[0m %s\n' "$*" >&2; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || die "bootstrap.sh is macOS-only; on Linux clone the repo and run ./install.sh"

install_clt() {
	xcode-select -p >/dev/null 2>&1 && return 0

	info "installing Xcode Command Line Tools (headless)"
	local marker=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress label
	touch "$marker"
	label="$(softwareupdate -l 2>/dev/null |
		sed -n 's/^[[:space:]]*\* Label: \(Command Line Tools.*\)$/\1/p' |
		sort -V | tail -n1)"
	if [[ -n $label ]]; then
		sudo softwareupdate -i "$label" --verbose || true
	fi
	rm -f "$marker"

	if ! xcode-select -p >/dev/null 2>&1; then
		info "falling back to the GUI installer — finish the dialog, this script waits"
		xcode-select --install >/dev/null 2>&1 || true
		until xcode-select -p >/dev/null 2>&1; do sleep 10; done
	fi
}

install_brew() {
	if [[ ! -x /opt/homebrew/bin/brew && ! -x /usr/local/bin/brew ]]; then
		info "installing Homebrew"
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	if [[ -x /opt/homebrew/bin/brew ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	else
		eval "$(/usr/local/bin/brew shellenv)"
	fi
}

clone_repo() {
	if [[ -d "$DOTFILES/.git" ]]; then
		info "updating $DOTFILES"
		git -C "$DOTFILES" pull --ff-only || info "could not fast-forward $DOTFILES, using it as is"
	else
		info "cloning $REPO_URL into $DOTFILES"
		git clone --branch "$BRANCH" "$REPO_URL" "$DOTFILES"
	fi
}

info "asking for the admin password once (CLT + Homebrew need it)"
# shellcheck disable=SC2024 # sudo reads the password from the tty, not the curl pipe
sudo -v </dev/tty

install_clt
install_brew
clone_repo

cd "$DOTFILES"
# stdin is the curl pipe; reattach the terminal so install.sh can prompt.
if [[ -r /dev/tty ]]; then
	exec ./install.sh "$@" </dev/tty
else
	exec ./install.sh "$@"
fi
