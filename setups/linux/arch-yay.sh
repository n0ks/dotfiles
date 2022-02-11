#!/usr/bin/env bash

source setups/shared.sh

declare -a arch_packages=(
	"alacritty"
	"automake"
	"base-devel"
	"bat"
	"cht.sh-git"
	"curl"
	"cmake"
	"ninja"
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
	"lsof"
	"ripgrep"
	"rlwrap"
	"screenkey"
	"shellcheck"
	"stow"
	"tmux"
	"ttf-twemoji"
	"ueberzug"
	"vim"
	"wget"
	"xclip"
	"zsh"
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
