alias localhost_run='ssh -R 80:localhost:8080 nokey@localhost.run'
alias localhost_run_cra='ssh -R 80:localhost:3000 nokey@localhost.run'
alias clr='clear'

#neovim
alias v='nvim'
alias nivm='nvim'
# Terraform
alias tfi='tf init'
alias tfp='tf plan'
alias tfpd='tf plan -destroy'
alias tfa='tf apply'
alias tfd='tf destroy'
alias tfc='tf console'
# Cloudflared
alias cfd='cloudflared'

alias imgcat='wezterm imgcat'

alias sudo='sudo '

alias cp='cp -iv --reflink=auto --sparse=always'
alias mv='mv -iv'
#alias rm='rm -v'

alias src='reload'


unalias l
unalias la
unalias ll
unalias ls
unalias lsa

if (( $+commands[bat] && ! ${+ZSH_CAT_PREFER_CAT} )); then
  typeset -g bat_params; bat_params=()

  function cat(){
    bat ${bat_params} $@
  }
  compdef cat=bat
else
  typeset -g _cat
  _cat=(=cat)

  typeset -g _cat_params
  _cat_params=()


  function cat(){
    $_cat ${_cat_params} $@
  }
  compdef cat=cat
fi


if [[ -f /etc/pacman.conf ]] then
	alias dragon='dragon-drop'
fi

alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'


alias lf='lfcd'
