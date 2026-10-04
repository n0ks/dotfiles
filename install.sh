#!/usr/bin/env bash
# Entry point once the repo is cloned (bootstrap.sh calls it for you):
#
#   ~/.dotfiles/install.sh                   # interactive, asks about GUI apps
#   ~/.dotfiles/install.sh --apps --yes      # everything, no prompts
#   ~/.dotfiles/install.sh --help            # all flags
#
# macOS → setups/mac/mac-setup.sh (flags are passed through)
# Linux → asks for Arch/Debian and runs the matching script in setups/linux/

cd "$(dirname "$0")" || exit 1

if [[ "$OSTYPE" == "darwin"* ]]; then
	./setups/mac/mac-setup.sh "$@"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	read -r -p "Are you on Arch or Debian? (a/d): " answer
	if [ "$answer" == "a" ]; then
		echo "You are on Arch"
		./setups/linux/arch-yay.sh
	elif [ "$answer" == "d" ]; then
		echo "You are on Debian"
		./setups/linux/debian-apt.sh
	else
		echo "You answered $answer"
	fi
else
	echo "You are on an unknown OS"
fi
