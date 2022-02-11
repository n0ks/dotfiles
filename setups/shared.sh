#!/usr/bin/env bash

# shellcheck disable=2164,1090

set -o allexport
source ~/.dotfiles/.env
set +o allexport

declare -a npm_packages=(
  "vscode-langservers-extracted"
  "typescript-language-server"
  "yaml-language-server"
  "diagnostic-languageserver"
  "eslint_d"
  "prettier"
  "yarn"
)

installNpmPackages() {
  npm i -g "${npm_packages[@]}"
}


neovimSetup() {
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

  if command -v pip3 2>/dev/null; then
    pip3 install neovim python-language-server pylint pynvim
  fi

}

chtshSetup(){
  PATH_DIR="$HOME/bin"  # or another directory on your $PATH
  mkdir -p "$PATH_DIR"
  curl https://cht.sh/:cht.sh > "$PATH_DIR/cht.sh"
  chmod +x "$PATH_DIR/cht.sh"
}

asdfSetup() {
  # Install useful plugins
  echo "[INFO] Installing asdf plugins..."
  echo ". $HOME/.asdf/asdf.sh" >>~/.bashrc
  source ~/.bashrc

 if command -v asdf &>/dev/null; then
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf plugin-add python
  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf plugin-add golang https://github.com/kennyp/asdf-golang.git

  # install from .tools-version
  asdf install
  fi
}

postInstall(){
  ~/.fzf/install --all
  curl --proto '=https' --tlsv-11.2 -sSf https://sh.rustup.rs | sh -s -- -y
  go install mvdan.cc/sh/v3/cmd/shfmt@latest
  cargo install stylua
  nvim --headless +PlugInstall +qall >/dev/null
}


onEndScript() {
  # Change the shell to zsh
  echo "[INFO] Changing the shell of this user to use zsh..."
  zsh_path=$(which zsh)
  chsh -s "$zsh_path"
}

cloneRepos() {
  echo "[INFO] cloning repos"
  git clone https://github.com/neovim/neovim.git ~/code/neovim
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  git clone https://github.com/sumneko/lua-language-server ~/code/lua-language-server
}

dotfilesStow() {
  for folder in $STOW_FOLDERS; do
      echo "Stowing $folder"
      stow -R "$folder"
  done
}