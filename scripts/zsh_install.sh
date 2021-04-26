if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache zsh
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install -y zsh
elif [ -x "$(command -v yay)" ]; then yay --noconfirm -S zsh
elif [ -x "$(command -v pacman)" ]; then pacman -S --noconfirm zsh
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: zsh">&2; fi
