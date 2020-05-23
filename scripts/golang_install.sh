VERSION=1.14.3

unameOs="$(uname)"
unameArch="$(uname -m)"



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