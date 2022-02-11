#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
	./setups/mac/mac-setup.sh
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	read -p "Are you on Arch or Debian? (a/d): " answer
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
