#!/usr/bin/env bash

echo "Hello $(whoami)! Let's get you set up."

echo "Shell installation script for n0ks dotfiles";
echo "-------------------------------------------------";

installSoftware() {
  echo "[INFO] Installing required software..";

  sudo apt install -y --ignore-missing ninja-build gettext libtool libtool-bin zsh curl wget python3-pip build-essential cmake g++ \
    autoconf unzip libssl-dev libncurses5-dev libreadline-dev zlib1g-dev automake doxygen exa xclip \
    libsqlite3-dev inotify-tools pkg-config fd-find bat ripgrep fzf tmux git stow screenkey gnome-tweaks

  if ! command -v gh &> /dev/null
  then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
  fi

  # Change the shell to zsh
  echo "[INFO] Changing the shell of this user to use zsh...";
  chsh -s $(which zsh)

  ~/.fzf/install

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  cargo install stylua

}

cloneRepos() {
  echo "[INFO] cloning repos"
  git clone https://github.com/n0ks/dotfiles ~/.dotfiles
  git clone https://github.com/neovim/neovim.git ~/code/neovim
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
  git clone https://github.com/sumneko/lua-language-server ~/code/lua-language-server
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

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
  # install from .tools-version
  asdf install
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

  pushd ~/code/lua-language-server
  git submodule update --init --recursive
  cd 3rd/luamake
  ./compile/install.sh
  cd ../../
  ./3rd/luamake/luamake rebuild
  popd

}

installNpmPackages(){
  npm i -g vscode-langservers-extracted
  npm i -g typescript typescript-language-server diagnostic-languageserver eslint_d yarn
}

alacrittySetup(){
  echo "[INFO] setting up alacritty"

  # setup from repo
  sudo add-apt-repository ppa:mmstick76/alacritty
  sudo apt install alacritty
}


setup(){
  cloneRepos;
  installSoftware;
  dotfilesStow;
  asdfSetup;
  neovimSetup;
  alacrittySetup;
}

read -p "Setup is about to start. Do you want to continue? (y/n) " -n 1;

if [[ $REPLY =~ ^[Yy]$ ]]; then
  setup;
fi;


