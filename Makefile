default:
	@echo "profiles: workstation, server"
	@echo "configs: alacritty, antigen, awesomewm, fzf, git, ideavim, neovim, powerline, ssh, tmux, wezterm, xfce, zsh"
profile_workstation:
	./install-profile workstation
profile_server:
	./install-profile server
config_alacritty:
	./install-standalone alacritty
config_antigen:
	./install-standalone antigen
config_awesomewm:
	./install-standalone awesomewm
config_fzf:
	./install-standalone fzf
config_git:
	./install-standalone git
config_ideavim:
	./install-standalone ideavim
config_neovim:
	./install-standalone neovim
config_powerline:
	./install-standalone powerline
config_ssh:
	./install-standalone ssh
config_tmux:
	./install-standalone tmux
config_wezterm:
	./install-standalone wezterm
config_xfce:
	./install-standalone xfce
config_zsh:
	./install-standalone zsh
