#!/usr/bin/env bash

set -o allexport; source .env; set +o allexport

for folder in $STOW_FOLDERS
do
    printf "Deleting $STOW_FOLDERS"
    stow -D $folder
done

