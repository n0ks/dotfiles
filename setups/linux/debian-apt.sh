#!/usr/bin/env bash

source ../shared.sh

declare -a apt_packages=(
  "autoconf"
  "automake"
  "bat"
  "build-essential"
  "cmake"
  "curl"
  "doxygen"
  "exa"
  "fd-find"
  "g++"
  "gettext"
  "git"
  "inotify-tools"
  "libncurses5-dev"
  "libreadline-dev"
  "libsqlite3-dev"
  "libssl-dev"
  "libtool"
  "libtool-bin"
  "ninja-build"
  "figlet"
  "pkg-config"
  "python3-pip"
  "ripgrep"
  "rlwrap"
  "screenkey"
  "stow"
  "tmux"
  "unzip"
  "wget"
  "xclip"
  "zlib1g-dev"
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
  echo "[INFO] Installing required software.."

  sudo apt update && sudo apt upgrade
  sudo apt install -y --ignore-missing "${apt_packages[@]}"

  if ! command -v gh &>/dev/null; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    sudo apt update
    sudo apt install gh
  fi
 
}

alacrittySetup() {
  echo "[INFO] setting up alacritty"
  # setup from repo
  sudo add-apt-repository ppa:mmstick76/alacritty
  sudo apt install alacritty -y
}

setup() {
  cloneRepos
  installSoftware
  dotfilesStow
  asdfSetup
  installNpmPackages
  neovimSetup
  alacrittySetup
  postInstall
  onEndScript
  }

main
