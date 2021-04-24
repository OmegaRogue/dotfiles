if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache zsh
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install -y zsh
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: zsh">&2; fi
