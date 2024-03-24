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


alias scg-add-requires= 'systemctl --global add-requires'
alias scg-add-wants= 'systemctl --global add-wants'
alias scg-cancel='systemctl --global cancel'
alias scg-cat='systemctl --global cat'
alias scg-daemon-reexec='systemctl --global daemon-reexec'
alias scg-daemon-reload='systemctl --global daemon-reload'
alias scg-default='systemctl --global default'
alias scg-disable='systemctl --global disable'
alias scg-disable-now='scu-disable --now'
alias scg-edit='systemctl --global edit'
alias scg-emergency='systemctl --global emergency'
alias scg-enable='systemctl --global enable'
alias scg-enable-now='scu-enable --now'
alias scg-failed='systemctl --global --failed'
alias scg-get-default='systemctl --global get-default'
alias scg-halt='systemctl --global halt'
alias scg-help='systemctl --global help'
alias scg-import-environment='systemctl --global import-environment'
alias scg-is-active='systemctl --global is-active'
alias scg-is-enabled='systemctl --global is-enabled'
alias scg-is-failed='systemctl --global is-failed'
alias scg-is-system-running='systemctl --global is-system-running'
alias scg-isolate='systemctl --global isolate'
alias scg-kexec='systemctl --global kexec'
alias scg-kill='systemctl --global kill'
alias scg-link='systemctl --global link'
alias scg-list-dependencies='systemctl --global list-dependencies'
alias scg-list-jobs='systemctl --global list-jobs'
alias scg-list-machines='systemctl --global list-machines'
alias scg-list-sockets='systemctl --global list-sockets'
alias scg-list-timers='systemctl --global list-timers'
alias scg-list-unit-files='systemctl --global list-unit-files'
alias scg-list-units='systemctl --global list-units'
alias scg-load='systemctl --global load'
alias scg-mask='systemctl --global mask'
alias scg-mask-now='scu-mask --now'
alias scg-preset='systemctl --global preset'
alias scg-preset-all='systemctl --global preset-all'
alias scg-reenable='systemctl --global reenable'
alias scg-reload='systemctl --global reload'
alias scg-reload-or-restart='systemctl --global reload-or-restart'
alias scg-rescue='systemctl --global rescue'
alias scg-reset-failed='systemctl --global reset-failed'
alias scg-restart='systemctl --global restart'
alias scg-revert='systemctl --global revert'
alias scg-set-default='systemctl --global set-default'
alias scg-set-environment='systemctl --global set-environment'
alias scg-set-property='systemctl --global set-property'
alias scg-show='systemctl --global show'
alias scg-show-environment='systemctl --global show-environment'
alias scg-start='systemctl --global start'
alias scg-status='systemctl --global status'
alias scg-stop='systemctl --global stop'
alias scg-switch-root='systemctl --global switch-root'
alias scg-try-reload-or-restart='systemctl --global try-reload-or-restart'
alias scg-try-restart='systemctl --global try-restart'
alias scg-unmask='systemctl --global unmask'
alias scg-unset-environment='systemctl --global unset-environment'

alias colap="colmena apply"

#unalias l
#unalias la
#unalias ll
#unalias ls
#unalias lsa

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

alias kikitf='flatpak run --command=sh org.kicad.KiCad -- python -m kikit.ui'
