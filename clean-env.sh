#!/usr/bin/env bash

set -o allexport; source .env; set +o allexport
for f in $STOW_FOLDERS
do
  echo $f
done
# for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
# do
#     printf "Deleting $STOW_FOLDERS"
#     stow -D $folder
# done

