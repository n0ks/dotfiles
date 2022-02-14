#!/usr/bin/env bash

set -o allexport
source ./.env
set +o allexport

for folder in $STOW_FOLDERS; do
	echo "Stowing $folder"
	stow -R "$folder"
done
