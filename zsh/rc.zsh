#setopt SOURCE_TRACE
#setopt XTRACE

setopt autocd
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt extended_glob          # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc. (An initial unquoted ‘~’ always produces named directory expansion.)
setopt AUTO_PUSHD			  # Make cd push the old directory onto the directory stack. 
setopt interactive_comments

zmodload zsh/mathfunc
autoload -Uz zmathfunc
autoload -Uz zcalc
autoload -U calendar

# ensure correct PATH zshenv
alias -g egrep='grep -E '
source $HOME/.zshenv

if [[ $(uname -r) == *WSL* ]]; then
	$HOME/.local/bin/gpg-agent-relay start
fi



if (( $+commands[powerline-daemon] )); then
	powerline-daemon -q
fi

# Search repos for programs that can't be found
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null


function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

source $HOME/.zsh_plugins
source $HOME/.zshenv

# Alias definitions.
if [ -f $HOME/.zsh_aliases ]; then
  source $HOME/.zsh_aliases
fi

if [[ -z $SSH_CONNECTION ]]; then
	gpgconf --launch gpg-agent
fi

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh


source $DOTFILE_ROOT/zsh/functions.zsh
 
fpath+=${ZDOTDIR:-$HOME}/.zsh_functions
fpath+=$DOTFILE_ROOT/zsh/completions/**
fpath+=$DOTFILE_ROOT/zsh/functions.zsh

autoload -U compinit
autoload -U bashcompinit
compinit
complete -o nospace -C /usr/bin/nomad nomad
bashcompinit

if (( $+commands[pipx] )); then
	eval "$(register-python-argcomplete pipx)"
fi


source /usr/lib/python3.11/site-packages/powerline/bindings/zsh/powerline.zsh
if (( $+commands[broot] )); then
	source ${XDG_CONFIG_HOME}/broot/launcher/bash/br
fi

nostdout
cdbk -d pr
cdbk -r cfg $XDG_CONFIG_HOME
cdbk -r dat $XDG_DATA_HOME
cdbk -r tr $XDG_DATA_HOME/Trash/files
cdbk -r us /run/media/omegarogue
cdbk -r m /mnt
cdbk -r mb /mnt/butter
cdbk -r mc /mnt/c
cdbk -r mda /mnt/omegadata
cdbk -r mdr /mnt/omegadrive
cdbk -r mm /mnt/movies
cdbk -r mr /mnt/rpg_stuff
cdbk -r mt /mnt/tv_shows
cdbk -r v $HOME/Videos
cdbk -r va $HOME/Videos/anime
cdbk -r p $HOME/Pictures
cdbk -r ps $HOME/Pictures/screenshots
cdbk -r d $HOME/Documents
cdbk -r Dw $HOME/Downloads
cdbk -r e $HOME/Desktop
cdbk -r r $HOME/projects
cdbk -r rs $HOME/src
cdbk -r Dt $DOTFILE_ROOT
cdbk -r c $XDG_CONFIG_HOME
cdbk -r l $HOME/.local
cdbk -r ls $XDG_DATA_HOME
cdbk -r lsf11 $XDG_DATA_HOME/FoundryVTTv11
cdbk -r lsf10 $XDG_DATA_HOME/FoundryVTTv10
cdbk -r lsf9 $XDG_DATA_HOME/FoundryVTTv9
cdbk -r E /etc
cdbk -r Ucd /usr
cdbk -r Us /usr/share
yesstdout
#neofetch
#zsh-startify

[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh

source $XDG_CONFIG_HOME/broot/launcher/bash/br
