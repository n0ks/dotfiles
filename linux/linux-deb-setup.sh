#!/usr/bin/env bash

echo "Hello $(whoami)! Let's get you set up."

echo "Shell installation script for n0ks dotfiles";
echo "-------------------------------------------------";
echo "";

installSoftware() {
	echo "[INFO] Installing required software..";

  sudo apt install -y ninja-build gettext libtool libtool-bin zsh curl wget python-pip build-essential cmake g++\ 
  autoconf unzip libssl-dev libncurses5-dev libreadline-dev zlib1g-dev automake doxygen exa \
  libsqlite3-dev inotify-tools pkg-config fd-find bat ripgrep fzf tmux git stow screenkey \

  # Change the shell to zsh
	echo "[INFO] Changing the shell of this user to use zsh...";
	chsh -s $(which zsh)

}

cloneRepos() {
	echo "[INFO] cloning repos"
	git clone https://github.com/n0ks/dotfiles ~/.dotfiles
	git clone https://github.com/alacritty/alacritty.git ~/code
	git clone https://github.com/neovim/neovim.git ~/code
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

}

dotfilesStow (){
	pushd ~/.dotfiles; chmod +x install.sh; source ./install.sh; popd
	echo `pwd`
	source ~/.zshrc
}

asdfSetup() {

	# Install useful plugins 
	echo "[INFO] Installing asdf plugins...";
	source $HOME/.asdf/asdf.sh;

	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
	asdf plugin-add java https://github.com/halcyon/asdf-java.git
	asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
	asdf plugin-add python
}

neovimSetup(){
  echo "[INFO] setting up vim-plug"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  pushd ~/code/neovim
  rm -rf build/
  git checkout master
  git pull
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  popd
}

setup(){
	installSoftware;
	cloneRepos;
	asdfSetup;
	dotfilesStow;
}

read -p "Setup is about to start. Do you want to continue? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	setup;
fi;


