# vim: set ft=zsh:
export QT_QPA_PLATFORMTHEME=gtk2
if [[ "$(tty)" = "/dev/tty1" ]]; then
	if pgrep awesome; then
		nm-applet &
		.screenlayout/screens.sh &
		barriers --disable-crypto --enable-drag-drop -l /var/log/barrier.log -c $HOME/.dotfiles/barrier/pc.conf &
		xfsettingsd -d --replace &
		gnome-keyring-daemon &
		#xrdb ~/.Xresources &
		picom -b&
		flameshot &
		#dunst &
		#xrdb -load ~/.config/X11/xresources &

		gpgconf --launch gpg-agent &
	else
		startx "$HOME/.dotfiles/xorg/xinitrc"
	fi
fi
