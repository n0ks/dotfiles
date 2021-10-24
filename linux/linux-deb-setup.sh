#!/usr/bin/env bash

echo "Hello $(whoami)! Let's get you set up."

echo "Shell installation script for n0ks dotfiles";
echo "-------------------------------------------------";
echo "";

installSoftware() {
	echo "[INFO] Installing required software..";

  sudo apt install -y ninja-build gettext libtool libtool-bin zsh curl wget python-pip build-essential cmake g++\ 
  autoconf unzip libssl-dev libncurses5-dev libreadline-dev zlib1g-dev automake doxygen exa xclip \
  libsqlite3-dev inotify-tools pkg-config fd-find bat ripgrep fzf tmux git stow screenkey \

  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update
  sudo apt install gh


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
  npm i -g vscode-langservers-extracted

  pushd ~/code/neovim
  rm -rf build/
  git checkout master
  git pull
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  popd
}

alacrittySetup(){
  echo "[INFO] setting up alacritty"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  pushd ~/code/alacritty
  
  cargo build --release
  infocmp alacritty

  sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database
  # set as default term
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
  sudo update-alternatives --config x-terminal-emulator
}

setup(){
	installSoftware;
	cloneRepos;
	asdfSetup;
	dotfilesStow;
  neovimSetup;
}

read -p "Setup is about to start. Do you want to continue? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	setup;
fi;

