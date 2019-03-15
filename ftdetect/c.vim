" EFFECTS:  Guess whether the file is a C++ or a C header and call the
"           appropriate formatting function.
function! IsCPPHeader()
    let l:line_no =
        \ search(
            \ '\(namespace\)\|\(class\)\|\(public\)\|\(private\)\|\(protected\)',
            \ 'ncw')
    return l:line_no
endfunction

augroup c_detect
    au!
    autocmd BufNewFile,BufRead *.c  set filetype=c.doxygen
    " autocmd BufNewFile,BufRead *.h
        " \ execute 'set filetype='. IsCPPHeader() ? 'cpp.doxygen' : 'c.doxygen'
augroup end
