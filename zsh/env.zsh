
# export MAGIC_ENTER_OTHER_COMMAND='[[ $(ls . | wc -l) -le 30 ]] && ls -lh . || ls .'
# export MAGIC_ENTER_GIT_COMMAND='git status -u .'

export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

export TK_SILENCE_DEPRECATION=1
export DOTNET_ROOT="$HOME/.dotnet"

typeset -U path
typeset -TUx XDG_CONFIG_HOME xdg_config_home
typeset -TUx XDG_DATA_DIRS xdg_data_dirs


xdg_config_home+=$HOME/.config

xdg_data_dirs+=$HOME/.nix-profile/share

path+=$HOME/.dotnet
path+=("/usr/local/go/bin" "$HOME/go/bin")
path+=$HOME/.local/bin
path+=("$HOME/.npm-global/bin" "$XDG_CONFIG_HOME/yarn/global/node_modules/.bin")
path+=/usr/local/vpnclient
path+=$HOME/.cargo/bin
path+=("$ANDROID_HOME/tools" "$ANDROID_HOME/emulator" "$ANDROID_HOME/tools/bin" "$ANDROID_HOME/platform-tools")
path+=("$HOME/kiri/submodules/KiCad-Diff/" "$HOME/kiri/bin")
path+=$HOME/.dotfiles/scripts
path+=$HOME/.nix-profile/bin





#export MANPAGER="nvim -c MANPAGER -"
#export PAGER="nvim -c PAGER -"

#export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS

if [[ -n $(lspci | grep GeForce) ]]; then
	path+=/usr/local/cuda-11.3/bin
fi


if [[ -z $SSH_CONNECTION ]]; then
	export GPG_TTY=$(tty)
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi



export DEFAULT_USER=$USER


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Default Apps
export TERMINAL='wezterm'
export EDITOR='nvim'
export SYSTEMD_EDITOR=$EDITOR
export READER='zathura'
export PAGER='less'
export WM='awesome'

# Uncomment the following line to disable colors in ls.
#DISABLE_LS_COLORS="true"
#LOAD set LS_COLORS from .dircolors
if [ -f $HOME/.dircolors ]; then
  eval $(dircolors -b $HOME/.dircolors)
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export ANDROID_HOME="$HOME/Android/Sdk"
export SH_SYSTEM_CLIPBOARD_TMUX_SUPPORT=true
export TMUX_AUTOSTART=false
export WORKON_HOME="$HOME/.virtualenvs"
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
if [[ -f /usr/bin/virtualenvwrapper.sh ]]; then
	source /usr/bin/virtualenvwrapper.sh
fi
if [[ -d /opt/zephyr-sdk-0.14.1 ]]; then
	source /opt/zephyr-sdk-0.14.1/environment-setup-x86_64-pokysdk-linux
fi
export LF_BOOKMARK_PATH=${HOME}/bookmarks

export QT_QPA_PLATFORMTHEME=gtk2

export PATH
export XDG_DATA_DIRS
export XDG_CONFIG_HOME
export xdg_data_dirs
export xdg_config_home
