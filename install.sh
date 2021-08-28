#!/usr/bin/env bash

set -o allexport; source .env; set +o allexport

pushd ~/.dotfiles
for folder in $STOW_FOLDERS
do
    echo "Stowing $folder"
    stow -D $folder
    stow $folder
done
popd
