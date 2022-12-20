# Check if zgen load is installed
if [[ ! -d ~/.zgenom ]]; then
	git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# Essential
source ~/.zgenom/zgenom.zsh


zgenom autoupdate

if ! zgenom saved; then
    echo "Creating a zgenom save"

	zgenom compdef
	zgenom ohmyzsh											# https://github.com/ohmyzsh/oh-my-zsh
#	alias
#	unalias l
#	unalias la
#	unalias ll
#	unalias ls
#	unalias lsa

	zgenom ohmyzsh plugins/git								# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/git
	zgenom ohmyzsh plugins/colored-man-pages				# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/colored-man-pages
	zgenom ohmyzsh plugins/sudo								# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/sudo
	zgenom load desyncr/auto-ls								# https://github.com/desyncr/auto-ls
	zgenom load zpm-zsh/colors								# https://github.com/zpm-zsh/colors
	zgenom load hlissner/zsh-autopair						# https://github.com/hlissner/zsh-autopair
	zgenom load 0b10/cheatsheet								# https://github.com/0b10/cheatsheet
	zgenom load Tarrasch/zsh-bd								# https://github.com/Tarrasch/zsh-bd
	zgenom load jeffreytse/zsh-vi-mode						# https://github.com/jeffreytse/zsh-vi-mode
	zgenom load zdharma-continuum/fast-syntax-highlighting	# https://github.com/zdharma-continuum/fast-syntax-highlighting
	zgenom load MichaelAquilina/zsh-you-should-use			# https://github.com/MichaelAquilina/zsh-you-should-use
	zgenom load zsh-users/zsh-completions					# https://github.com/zsh-users/zsh-completions
	zgenom load zpm-zsh/ls									# https://github.com/zpm-zsh/ls
	zgenom load bartboy011/cd-reminder						# https://github.com/bartboy011/cd-reminder
	zgenom load peterhurford/git-it-on.zsh					# https://github.com/peterhurford/git-it-on.zsh
	zgenom load laggardkernel/git-ignore					# https://github.com/laggardkernel/git-ignore
	zgenom load knu/zsh-manydots-magic						# https://github.com/knu/zsh-manydots-magic
	zgenom load jgogstad/passwordless-history				# https://github.com/jgogstad/passwordless-history
	zgenom load aubreypwd/zsh-plugin-reload					# https://github.com/aubreypwd/zsh-plugin-reload
	zgenom load mattmc3/zsh-safe-rm						# https://github.com/mattmc3/zsh-safe-rm
	#zgenom load zshzoo/magic-enter							# https://github.com/zshzoo/magic-enter
	if hash tmux &>/dev/null; then
		zgenom load MikeDacre/tmux-zsh-vim-titles			# https://github.com/MikeDacre/tmux-zsh-vim-titles
		zgenom load zpm-zsh/tmux							# https://github.com/zpm-zsh/tmux
	fi
	if hash pacman &>/dev/null; then
		zgenom ohmyzsh plugins/archlinux					# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/archlinux
	fi

	zgenom save

	zgenom compile $HOME/.zshrc
fi

