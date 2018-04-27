" Buffer events
augroup buffer_stuff
    au!
    autocmd BufWritePre * call DeleteTrailing()
augroup END

" Trigger `autoread` when files change on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
augroup autoread
    au!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "Detected changes to a loaded file. Buffer may have been reloaded." | echohl None
augroup END

" Perform certain actions the first time a user's cursor enters a buffer.
"
" Did this because `WinEnter` seems to be the first autocmd that fires late
" enough that global options (like `foldmethod`) can take effect beforehand.
" `WinEnter` does not fire once per buffer, hence the buffer-local flag.
"
" Adapted from:
"   http://vim.wikia.com/wiki/Folding#Indent_folding_with_manual_folds
augroup firstread
    au!
    autocmd BufReadPre,BufWinEnter * let b:firstread=1

    " Add additional commands to the if-statement below.
    autocmd WinEnter *
    \ if b:firstread
        \ | setlocal foldmethod=manual
    \ | endif

    autocmd BufLeave * if b:firstread | let b:firstread = 0 | endif
augroup END
