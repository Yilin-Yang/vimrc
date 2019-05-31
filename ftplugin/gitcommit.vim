if exists('*ColorColumnBlock')
  " Subject line is <= 50 characters long.
  " Body is <= 72 characters wide.
  autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained
      \ <buffer>
      \ execute 'call ColorColumnBlock(' . ( line('.') ==# 1 ? '51)' : '73)' )
endif
