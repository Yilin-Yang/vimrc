"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   C++ Formatting                                          [CPP]
"   Python Formatting                                       [PYTHON]
"   AutoHotkey Formatting                                   [AUTOHOTKEY]
"   TeX Formatting                                          [TEX]
"   Snippets                                                [SNIPPETS]
"   YAML Formatting                                         [YAML]
"=============================================================================

"=============================================================================
"   C++ Formatting                                          [CPP]
"=============================================================================

" Set C++ specific formatting options.
function! CppFormat()
    setlocal colorcolumn=81         " My personal line limit
    set filetype=cpp.doxygen        " And highlight doxygen formatting
endfunction

" C++ Formatting
" .cpp files
 augroup cpp_format
    au!
    autocmd BufRead *.cpp   call CppFormat()
    autocmd BufRead *.hpp   call CppFormat()
 augroup end

"=============================================================================
"   Python Formatting                                       [PYTHON]
"=============================================================================

function! PyFormat()
    setlocal colorcolumn=80             " PEP-standard lines are 79 characters max
endfunction

augroup py_format
    au!
    autocmd BufRead *.py    call PyFormat()
augroup end

"=============================================================================
"   TeX Formatting                                          [TEX]
"=============================================================================

function! TeXFormat()
    call EnableLexical()
    call TextWrap(1)

    " Opening double quote.
    inoremap <leader>` ``
    inoremap <leader>' ''
endfunction

function! TeXUnformat()
    iunmap <leader>`
    iunmap <leader>'
endfunction

augroup tex_format
    au!
    autocmd filetype tex    call TeXFormat()
    autocmd BufEnter *.tex  set filetype=tex
    autocmd BufLeave *.tex  call TeXUnformat()
augroup end

"=============================================================================
"   AutoHotkey Formatting                                   [AUTOHOTKEY]
"=============================================================================

" Set AutoHotkey specific formatting options.
function! AhkFormat()
    setlocal noexpandtab
endfunction

augroup ahk_format
    autocmd filetype autohotkey call AhkFormat()
    autocmd BufRead *.ahk       set filetype=autohotkey
    au!
augroup end

"=============================================================================
"   Snippets                                                [SNIPPETS]
"=============================================================================

augroup snippets_format
    au!
    autocmd filetype snippets   setlocal expandtab
augroup end

"=============================================================================
"   YAML Formatting                                         [YAML]
"=============================================================================

augroup yaml_format
    au!
    autocmd filetype yaml   setlocal expandtab
augroup END
