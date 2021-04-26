if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache neovim
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install -y neovim
elif [ -x "$(command -v yay)" ]; then yay --noconfirm -S neovim
elif [ -x "$(command -v pacman)" ]; then pacman -S --noconfirm neovim
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: neovim">&2; fi
