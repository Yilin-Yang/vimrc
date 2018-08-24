" Buffer events
augroup buffer_stuff
    au!
    autocmd BufWritePre * if &filetype !=# 'vader' | call DeleteTrailing() | endif
augroup end

" Trigger `autoread` when files change on disk
"   https://unix.stackexchange.com/a/383044
"   https://vi.stackexchange.com/q/13692
augroup autoread
    au!
    autocmd FocusGained, BufEnter, CursorHold, CursorHoldI *
        \ if &buftype !=# 'nofile' && mode() != 'c'
            \ | checktime
        \ | endif
    " Notification after file change
    "   https://vi.stackexchange.com/q/13091
    autocmd FileChangedShellPost *
        \ echohl WarningMsg
        \ | echo 'Detected changes to a loaded file. Buffer may have been reloaded.'
        \ | echohl None
augroup end

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
    autocmd BufReadPre,BufWinEnter * silent let b:firstread = 1

    " Add additional commands to the if-statement below.
    " Use :silent! to prevent annoying error messages when opening an unnamed
    " buffer, leaving a NERDtree buffer, etc.
    autocmd WinEnter *
        \ silent! if b:firstread
            \ | setlocal foldmethod=manual
        \ | endif

    autocmd BufLeave * silent! if b:firstread | let b:firstread = 0 | endif
augroup end
