default:
	@echo 'profiles: server, workstation'
	@echo 'configs: alacritty, antigen, awesomewm, fzf, git, ideavim, lf, neovim, paru, picom, powerline, rofi, ssh, tmux, wezterm, xfce, xorg, zsh'

profile_server:
	/home/omegarogue/.dotfiles/install-profile server
profile_workstation:
	/home/omegarogue/.dotfiles/install-profile workstation

config_alacritty:
	/home/omegarogue/.dotfiles/install-standalone alacritty
config_antigen:
	/home/omegarogue/.dotfiles/install-standalone antigen
config_awesomewm:
	/home/omegarogue/.dotfiles/install-standalone awesomewm
config_fzf:
	/home/omegarogue/.dotfiles/install-standalone fzf
config_git:
	/home/omegarogue/.dotfiles/install-standalone git
config_ideavim:
	/home/omegarogue/.dotfiles/install-standalone ideavim
config_lf:
	/home/omegarogue/.dotfiles/install-standalone lf
config_neovim:
	/home/omegarogue/.dotfiles/install-standalone neovim
config_paru:
	/home/omegarogue/.dotfiles/install-standalone paru
config_picom:
	/home/omegarogue/.dotfiles/install-standalone picom
config_powerline:
	/home/omegarogue/.dotfiles/install-standalone powerline
config_rofi:
	/home/omegarogue/.dotfiles/install-standalone rofi
config_ssh:
	/home/omegarogue/.dotfiles/install-standalone ssh
config_tmux:
	/home/omegarogue/.dotfiles/install-standalone tmux
config_wezterm:
	/home/omegarogue/.dotfiles/install-standalone wezterm
config_xfce:
	/home/omegarogue/.dotfiles/install-standalone xfce
config_xorg:
	/home/omegarogue/.dotfiles/install-standalone xorg
config_zsh:
	/home/omegarogue/.dotfiles/install-standalone zsh