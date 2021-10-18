#!/usr/bin/env bash

# Ask for the administrator password upfront
# sudo -v

# Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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

cloneRepos() {
  echo "mkdir -p ${HOME}/code"
  mkdir -p "${HOME}/code"
  mkdir -p "${HOME}/.dotfiles"

  echo "[INFO] cloning repos"
  git clone https://github.com/n0ks/dotfiles.git "${HOME}/.dotfiles"
  git clone https://github.com/alacritty/alacritty.git "${HOME}/code"
  git clone https://github.com/neovim/neovim.git "${HOME}/code"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

}

asdfSetup() {
  source ~/.zshrc

	# Install useful plugins 
	echo "[INFO] Installing asdf plugins...";
	source $HOME/.asdf/asdf.sh;

  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
  asdf plugin-add python

}

macSettings() {
  osascript -e 'tell application "System Preferences" to quit'
  source ./macos-settings
}

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change

setup(){
    installSoftware;
    cloneRepos;
    installAsdf;
    macSettings
}

read -p "Setup is about to start. Do you want to continue? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		setup;
	fi;


