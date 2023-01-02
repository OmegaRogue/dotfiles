#setopt SOURCE_TRACE
#setopt XTRACE

setopt autocd
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt extended_glob

# ensure correct PATH zshenv
alias -g egrep='grep -E '
source $HOME/.zshenv

if [[ $(uname -r) == *WSL* ]]; then
	$HOME/.local/bin/gpg-agent-relay start
fi



if (( $+commands[powerline-daemon] )); then
	powerline-daemon -q
fi

source $HOME/.zsh_plugins

# Alias definitions.
if [ -f $HOME/.zsh_aliases ]; then
  source $HOME/.zsh_aliases
fi

if [[ -z $SSH_CONNECTION ]]; then
	gpgconf --launch gpg-agent
fi

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh


source $HOME/.dotfiles/zsh/functions.zsh
 
fpath+=${ZDOTDIR:-$HOME}/.zsh_functions
fpath+=$HOME/.dotfiles/zsh/completions/**
fpath+=$HOME/.dotfiles/zsh/functions.zsh

autoload -U compinit
compinit
complete -o nospace -C /usr/bin/nomad nomad

source $HOME/.local/lib/python3.10/site-packages/powerline/bindings/zsh/powerline.zsh
# Search repos for programs that can't be found
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null

if (( $+commands[broot] )); then
	source ${XDG_CONFIG_HOME}/broot/launcher/bash/br
fi




#neofetch
#zsh-startify

[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh
