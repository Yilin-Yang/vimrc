"-----------------------------------------------------------------------------
" EFFECTS:  Dispatches to the appropriate debugger Start function based on the
"           type of the current file.
"-----------------------------------------------------------------------------
function! Debug(...)
    if match(&filetype, "cpp") !=? -1
        " Start lldb.nvim.
        call StartConqueGDB()
    elseif &filetype == "python"
        let filename = @%

        " Weird double `call` allows for expansion of an argslist.
        " See `:h call()` for details.
        call call('StartVebugger', ["PDB", filename] + a:000)
    endif
endfunction " Debug

command! -nargs=* D call Debug(<args>)
