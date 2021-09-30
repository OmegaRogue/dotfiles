VERSION=1.17.1

unameOs="$(uname)"
unameArch="$(uname -m)"

currentVer="$(go version | grep -oP '\d+\.\d+\.\d+')"

if ! $(echo -n ${currentVer} | grep -q ${VERSION}) ; 
then

    case "${unameOs}" in
        Linux*)     OS=linux;;
        Darwin*)    OS=darwin;;
    esac

    case "${unameArch}" in
        x86_64*)     ARCH=amd64;;
        i386*)       ARCH=386;;
        i686*)       ARCH=386;;
        armv7l*)     ARCH=armv6l;;
    esac

    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz -P ~/downloads/
    sudo tar -C /usr/local -xzf ~/downloads/go$VERSION.$OS-$ARCH.tar.gz

else

    echo -e "\033[93mAlready Up to date."

fi

