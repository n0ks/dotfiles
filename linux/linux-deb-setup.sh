#!/usr/bin/env bash

echo "Hello $(whoami)! Let's get you set up."

echo "Shell installation script for n0ks dotfiles";
echo "-------------------------------------------------";
echo "";

installSoftware() {
  echo "[INFO] Installing required software..";

  sudo apt-get install -y zsh git-core curl wget python-pip build-essential \ 
  autoconf unzip libssl-dev libncurses5-dev libreadline-dev zlib1g-dev \
  libsqlite3-dev inotify-tools pkg-config fd bat rg fzf tmux git stow screenkey \

  # Change the shell to zsh
	echo "[INFO] Changing the shell of this user to use zsh...";
	chsh -s $(which zsh)

}

cloneRepos() {
  echo "mkdir -p ${HOME}/code"
  mkdir -p "${HOME}/code"

  echo "[INFO] cloning repos"
  git clone https://github.com/alacritty/alacritty.git "${HOME}/code"
  git clone https://github.com/neovim/neovim.git "${HOME}/code"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

}

dotfilesStow (){
 pushd ~/.dotfiles; chmod +x install.sh; source ./install.sh; popd
 echo `pwd`
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

setup(){
    installSoftware;
    cloneRepos;
    dotfilesStow;
    installAsdf;
}

read -p "Setup is about to start. Do you want to continue? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		setup;
	fi;


