
# export MAGIC_ENTER_OTHER_COMMAND='[[ $(ls . | wc -l) -le 30 ]] && ls -lh . || ls .'
# export MAGIC_ENTER_GIT_COMMAND='git status -u .'

export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

export TK_SILENCE_DEPRECATION=1
export DOTNET_ROOT="$HOME/.dotnet"
export DOTNET_ROOT=/opt/dotnet
typeset -U path
typeset -TUx XDG_CONFIG_DIRS xdg_config_dirs
typeset -TUx XDG_DATA_DIRS xdg_data_dirs

export DOTFILE_ROOT=$0:P:h:h

if [[ -z $XDG_DATA_HOME ]]; then
	export XDG_DATA_HOME=$HOME/.local/share
fi

if [[ -z $XDG_CONFIG_HOME ]]; then
	export XDG_CONFIG_HOME=$HOME/.config
fi
if [[ -z $XDG_CACHE_HOME ]]; then
	export XDG_CACHE_HOME=$HOME/.cache
fi

if [[ -z $XDG_STATE_HOME ]]; then
	export XDG_STATE_HOME=$HOME/.local/state
fi

xdg_data_dirs+=$HOME/.nix-profile/share


path_temp=($HOME/.dotnet)
path_temp+=("$HOME/go/bin" "/usr/local/go/bin")
path_temp+=$HOME/.local/bin
path_temp+=("$HOME/.npm-global/bin" "$XDG_CONFIG_HOME/yarn/global/node_modules/.bin")
path_temp+=/usr/local/vpnclient
path_temp+=$HOME/.cargo/bin
path_temp+=("$ANDROID_HOME/tools" "$ANDROID_HOME/emulator" "$ANDROID_HOME/tools/bin" "$ANDROID_HOME/platform-tools")
path_temp+=("$HOME/kiri/submodules/KiCad-Diff/" "$HOME/kiri/bin")
path_temp+=$DOTFILE_ROOT/scripts
path_temp+=$HOME/.nix-profile/bin
path=($path_temp $path)



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


path+="$(yarn global bin)"


export DEFAULT_USER=$USER

export NOMAD_ADDR="http://nomad.service.consul:4646"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Default Apps
export TERMINAL='wezterm'
export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='firefox'
export IMAGE='nsxiv'

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

lsd_params+='--hyperlink=always'

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
export XDG_CONFIG_DIRS
export xdg_config_dirs
export xdg_data_dirs
