if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi


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

source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

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


# autoload -Uz compinit
# autoload -Uz bashcompinit
# for dump in ~/.zcompdump(N.mh+24); do
#   compinit
#   bashcompinit
#   complete -o nospace -C /usr/bin/nomad nomad
# done
# compinit -C
# bashcompinit -C



if (( $+commands[pipx] )); then
	eval "$(register-python-argcomplete pipx)"
fi


source $(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")/powerline/bindings/zsh/powerline.zsh
if (( $+commands[broot] )); then
	source ${XDG_CONFIG_HOME}/broot/launcher/bash/br
fi
#neofetch
#zsh-startify

[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh

source $XDG_CONFIG_HOME/broot/launcher/bash/br

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /tmp/makepkg/material-companion/src/MaterialCompanion-1.0.3/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /tmp/makepkg/material-companion/src/MaterialCompanion-1.0.3/node_modules/tabtab/.completions/electron-forge.zsh
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
