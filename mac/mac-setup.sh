#!/usr/bin/env bash

# Ask for the administrator password upfront
# sudo -v

# Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#==============
# Install all the packages
#==============
sudo chown -R $(whoami):admin /usr/local

echo "Hello $(whoami)! Let's get you set up."

echo "installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

echo "mkdir -p ${HOME}/code"
mkdir -p "${HOME}/code"

echo "cloning repos"
git clone https://github.com/n0ks/dotfiles.git "${HOME}"
git clone https://github.com/alacritty/alacritty.git "${HOME}/code"
git clone https://github.com/neovim/neovim.git "${HOME}/code"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

xcode-select --install

