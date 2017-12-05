" Buffer events
augroup buffer_stuff
    au!
    autocmd BufWritePre * call DeleteTrailing()
augroup END
