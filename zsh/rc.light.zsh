#setopt SOURCE_TRACE
#setopt XTRACE

setopt autocd
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

powerline-daemon -q


source $HOME/.zsh_plugins

# ensure correct PATH zshenv
source $HOME/.zshenv



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi



fpath+=${ZDOTDIR:-~}/.zsh_functions

autoload -U +X bashcompinit && bashcompinit

. $HOME/.local/lib/python3.10/site-packages/powerline/bindings/zsh/powerline.zsh

