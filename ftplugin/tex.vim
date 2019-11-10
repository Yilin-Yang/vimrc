if exists('*EnableLexical')
  call EnableLexical()
endif
setlocal textwidth=80

" Opening double quote.
inoremap <buffer> <leader>` ``
inoremap <buffer> <leader>' ''
