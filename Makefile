gen:
	@${HOME}/.dotfiles/genMakefile.sh
default: gen
	@echo 'profiles: server, workstation'
	@echo 'configs: alacritty, antigen, awesomewm, fzf, git, ideavim, lf, neovim, paru, picom, powerline, rofi, ssh, tmux, wezterm, xfce, xorg, zsh'

profile_server: gen
	${HOME}/.dotfiles/install-profile server
profile_workstation: gen
	${HOME}/.dotfiles/install-profile workstation

config_alacritty: gen
	${HOME}/.dotfiles/install-standalone alacritty
config_antigen: gen
	${HOME}/.dotfiles/install-standalone antigen
config_awesomewm: gen
	${HOME}/.dotfiles/install-standalone awesomewm
config_fzf: gen
	${HOME}/.dotfiles/install-standalone fzf
config_git: gen
	${HOME}/.dotfiles/install-standalone git
config_ideavim: gen
	${HOME}/.dotfiles/install-standalone ideavim
config_lf: gen
	${HOME}/.dotfiles/install-standalone lf
config_neovim: gen
	${HOME}/.dotfiles/install-standalone neovim
config_paru: gen
	${HOME}/.dotfiles/install-standalone paru
config_picom: gen
	${HOME}/.dotfiles/install-standalone picom
config_powerline: gen
	${HOME}/.dotfiles/install-standalone powerline
config_rofi: gen
	${HOME}/.dotfiles/install-standalone rofi
config_ssh: gen
	${HOME}/.dotfiles/install-standalone ssh
config_tmux: gen
	${HOME}/.dotfiles/install-standalone tmux
config_wezterm: gen
	${HOME}/.dotfiles/install-standalone wezterm
config_xfce: gen
	${HOME}/.dotfiles/install-standalone xfce
config_xorg: gen
	${HOME}/.dotfiles/install-standalone xorg
config_zsh: gen
	${HOME}/.dotfiles/install-standalone zsh