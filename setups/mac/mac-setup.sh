#!/usr/bin/env bash

# Ask for the administrator password upfront
# sudo -v

# Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

source ../shared.sh

echo "Hello $(whoami)! Let's get you set up."

echo "Shell installation script for n0ks dotfiles";
echo "-------------------------------------------------";
echo "";

installSoftware() {
  echo "[INFO] setting up brew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew update

	# Install zsh and required software
	echo "[INFO] Installing from Brewfile";
  brew bundle --file="../Brewfile"
  xcode-select --install

}

macSettings() {
  osascript -e 'tell application "System Preferences" to quit'
  source ./macos-settings
}

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change

setup(){
    cloneRepos
    installSoftware
    dotfilesStow
    asdfSetup
    neovimSetup
}

read -p "Setup is about to start. Do you want to continue? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		setup;
	fi;


