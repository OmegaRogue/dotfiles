# Check if zgenom is installed
if [[ ! -d $HOME/.zgenom ]]; then
	git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# Essential
source $HOME/.zgenom/zgenom.zsh


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
	zgenom ohmyzsh plugins/git-flow							# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/git-flow
	zgenom ohmyzsh plugins/colored-man-pages				# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/colored-man-pages
	zgenom ohmyzsh plugins/sudo								# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/sudo
	# zgenom ohmyzsh plugins/magic-enter						# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/magic-enter
#	zgenom ohmyzsh plugins/command-not-found				# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/command-not-found
	zgenom ohmyzsh plugins/virtualenv						# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/virtualenv
	zgenom load desyncr/auto-ls								# https://github.com/desyncr/auto-ls
	zgenom load zpm-zsh/colors								# https://github.com/zpm-zsh/colors
	zgenom load hlissner/zsh-autopair						# https://github.com/hlissner/zsh-autopair
	zgenom load 0b10/cheatsheet								# https://github.com/0b10/cheatsheet
	zgenom load Tarrasch/zsh-bd								# https://github.com/Tarrasch/zsh-bd
	zgenom load kutsan/zsh-system-clipboard					# https://github.com/kutsan/zsh-system-clipboard
	zgenom load jeffreytse/zsh-vi-mode						# https://github.com/jeffreytse/zsh-vi-mode
	zgenom load zdharma-continuum/fast-syntax-highlighting	# https://github.com/zdharma-continuum/fast-syntax-highlighting
	zgenom load MichaelAquilina/zsh-you-should-use			# https://github.com/MichaelAquilina/zsh-you-should-use
	zgenom load zsh-users/zsh-completions					# https://github.com/zsh-users/zsh-completions
	zgenom load zpm-zsh/ls									# https://github.com/zpm-zsh/ls
	zgenom load elstgav/branch-manager						# https://github.com/elstgav/branch-manager
	zgenom load bartboy011/cd-reminder						# https://github.com/bartboy011/cd-reminder
	zgenom load peterhurford/git-it-on.zsh					# https://github.com/peterhurford/git-it-on.zsh
	zgenom load laggardkernel/git-ignore					# https://github.com/laggardkernel/git-ignore
	zgenom load reegnz/jq-zsh-plugin						# https://github.com/reegnz/jq-zsh-plugin
	zgenom load knu/zsh-manydots-magic						# https://github.com/knu/zsh-manydots-magic
	zgenom load zpm-zsh/template							# https://github.com/zpm-zsh/template
	zgenom load marcossegovia/open-create-projects			# https://github.com/marcossegovia/open-create-projects
	zgenom load jgogstad/passwordless-history				# https://github.com/jgogstad/passwordless-history
	#zgenom load jimhester/per-directory-history			# https://github.com/jimhester/per-directory-history
	zgenom load idadzie/zsh-presenter-mode					# https://github.com/idadzie/zsh-presenter-mode
	zgenom load voronkovich/project.plugin.zsh				# https://github.com/voronkovich/project.plugin.zsh
	#zgenom load michaelmcallister/razer-status-code			# https://github.com/michaelmcallister/razer-status-code
	zgenom load aubreypwd/zsh-plugin-reload					# https://github.com/aubreypwd/zsh-plugin-reload
	zgenom load mattmc3/zsh-safe-rm						# https://github.com/mattmc3/zsh-safe-rm
	zgenom load gko/ssh-connect								# https://github.com/gko/ssh-connect
	zgenom load NorthIsMirror/zsh-startify					# https://github.com/NorthIsMirror/zsh-startify
	zgenom load zshzoo/magic-enter							# https://github.com/zshzoo/magic-enter
	zgenom load nviennot/zsh-vim-plugin
	zgenom load jandamm/instant-repl.zsh
	zgenom load ahmubashshir/zinsults
	zgenom load MikeDacre/cdbk
	zgenom bin https://gitlab.com/axdsop/nix-dotfiles --location "Configs/polybar/scripts/mpris_player/mpris_player_control" --name "mpris_player_control"
	if  (( $+commands[pacman] )); then
		zgenom load Junker/zsh-archlinux
	fi
	# if (( $+commands[tmux] )); then
		zgenom load MikeDacre/tmux-zsh-vim-titles			# https://github.com/MikeDacre/tmux-zsh-vim-titles
		zgenom load zpm-zsh/tmux							# https://github.com/zpm-zsh/tmux
	# fi
	if (( $+commands[bw] )); then
		echo "test"
		zgenom load Game4Move78/zsh-bitwarden				# https://github.com/Game4Move78/zsh-bitwarden
	fi

	# if (( $+commands[nmap] )); then
		zgenom ohmyzsh plugins/nmap							# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/nmap
	# fi

	# if  (( $+commands[systemctl] )); then
		zgenom ohmyzsh plugins/systemd						# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/systemd
	# fi
	# if  (( $+commands[terraform] )); then
		zgenom ohmyzsh plugins/terraform					# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/terraform
	# fi

	# if (( $+commands[fzf] )); then
		zgenom load Aloxaf/fzf-tab								# https://github.com/Aloxaf/fzf-tab
		zgenom load redxtech/zsh-fzf-utils						# https://github.com/redxtech/zsh-fzf-utils
		zgenom ohmyzsh plugins/zsh-interactive-cd				# https://github.com/ohmyzsh/oh-my-zsh/tree/master/plugins/zsh-interactive-cd
	# fi
	case $(tty) in 
	/dev/tty[0-9]*);;
	*)
		zgenom load bric3/nice-exit-code					# https://github.com/bric3/nice-exit-code
		zgenom load fshp/schroot.plugin.zsh					# https://github.com/fshp/schroot.plugin.zsh
	;;
	esac

	zgenom load chisui/zsh-nix-shell
	zgenom load nix-community/nix-zsh-completions

	if [[ -e $HOME/.zgenom/sources/ohmyzsh/ohmyzsh/___/lib/theme-and-appearance.zsh ]] rm $HOME/.zgenom/sources/ohmyzsh/ohmyzsh/___/lib/theme-and-appearance.zsh
	if [[ -e $HOME/.zgenom/sources/ohmyzsh/ohmyzsh/___/lib/theme-and-appearance.zsh.zwc ]] rm $HOME/.zgenom/sources/ohmyzsh/ohmyzsh/___/lib/theme-and-appearance.zsh.zwc

	zgenom load arzzen/calc.plugin.zsh

	zgenom save

	# zgenom compile $HOME/.zshrc
fi

