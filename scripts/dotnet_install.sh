# get dotnet install script if not installed

if ! [[ -f ~/.scripts/dotnet-install.sh ]];
then

wget https://dot.net/v1/dotnet-install.sh -O ~/.dotfiles/scripts/dotnet-install.sh

chmod +x ~/.dotfiles/scripts/dotnet-install.sh

fi


~/.dotfiles/scripts/dotnet-install.sh -c Current