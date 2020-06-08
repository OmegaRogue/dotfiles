" Informative echo line
function! g:utils#showToggles() abort
  echom '<F1> Help | <F2> Reload rc | <F3> Whitechars | <F4> Exit | <F5> Void | <F6> Void |' .
        \' <F7> Void | <F8> Void | <F9> Void | <F10> Void  | <F11> Void |' .
        \' <F12> This message'
endfunction


" Fullscreen help
function! g:utils#showHelp() abort
  if &filetype ==# 'help'
    :close
  else
    :help
  endif
endfunction