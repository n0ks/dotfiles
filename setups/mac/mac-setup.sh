#!/bin/zsh
source ../shared.sh

echo "Hello $(whoami)! Let's get you set up."

echo "Shell installation script for n0ks dotfiles"
echo "-------------------------------------------------"
echo ""

echo Enter root password

# Ask for the administrator password upfront.
sudo -v

# Keep Sudo until script is finished
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

installSoftware() {
	echo "[INFO] setting up brew"
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# Append Homebrew initialization to .zprofile
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>${HOME}/.zprofile
	# Immediately evaluate the Homebrew environment settings for the current session
	eval "$(/opt/homebrew/bin/brew shellenv)"
	brew update && brew doctor
  export HOMEBREW_NO_INSTALL_CLEANUP=1

	echo "[INFO] Installing from Brewfile"
	brew bundle --file="../Brewfile"
	xcode-select --install

  brew update && brew upgrade && brew cleanup && brew doctor
}

macSettings() {
	ssh-keygen -t rsa
	osascript -e 'tell application "System Preferences" to quit'
	source ./macos-settings

  read -s -k $'?Press ANY KEY to REBOOT\n'
  sudo reboot
  exit
}

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change

setup() {
	cloneRepos
	installSoftware
	dotfilesStow
	asdfSetup
	neovimSetup
	macSettings
}

read -p "Setup is about to start. Do you want to continue? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
	setup
fi
