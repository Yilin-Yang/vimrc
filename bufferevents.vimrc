" Buffer events
augroup buffer_stuff
    au!
    autocmd BufWritePre * :%s/\s\+$//e "Delete trailing whitespace on save
augroup END
