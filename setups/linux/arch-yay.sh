#!/usr/bin/env bash

source setups/shared.sh

declare -a arch_packages=(
	"alacritty"
	"automake"
	"base-devel"
	"bat"
	"cht.sh-git"
	"cmake"
	"curl"
	"doxygen"
	"exa"
	"fd"
	"figlet"
	"flameshot"
	"git"
	"github-cli"
	"grep"
	"htop"
	"inotify-tools"
	"jq"
  "polybar"
	"lsof"
	"ninja"
	"ripgrep"
	"rlwrap"
	"screenkey"
	"shellcheck"
	"stow"
  "shfmt"
	"tmux"
	"ttf-twemoji"
	"ueberzug"
	"vim"
	"wget"
	"xclip"
	"zsh"
  "feh"
  "trash-cli"
  "zathura"
  "zathura-pdf-poppler"
  "starship"
)

main() {

	cat <<EOF

       ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫

                 Hello $(whoami)! Let's get you set up.          
               Shell installation script for n0ks dotfiles       

       ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫

EOF

	read -p "Setup is about to start. Do you want to continue? (y/n) " -n 1

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		setup
	fi
}

installSoftware() {
	yay -S --needed --answerclean=None --answerdiff=None "${arch_packages[@]}"
}

setup() {
	cloneRepos
	installSoftware
	dotfilesStow
	asdfSetup
	installNpmPackages
	neovimSetup
	postInstall
	onEndScript
}

main
