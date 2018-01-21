"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   C++ Formatting                                          [CPP]
"   Python Formatting                                       [PYTHON]
"   Markdown Formatting                                     [MARKDOWN]
"   AutoHotkey Formatting                                   [AUTOHOTKEY]
"   TeX Formatting                                          [TEX]
"   Snippets                                                [SNIPPETS]
"=============================================================================

"=============================================================================
"   C++ Formatting                                          [CPP]
"=============================================================================

" Set C++ specific formatting options.
function! CppFormat()
    set colorcolumn=81              " My personal line limit
    set filetype=cpp.doxygen        " And highlight doxygen formatting
endfunction

" C++ Formatting
" .cpp files
 augroup cpp_format
    au!
    autocmd BufEnter *.cpp              call CppFormat()
    autocmd BufEnter *.hpp              call CppFormat()
 augroup end

"=============================================================================
"   Python Formatting                                       [PYTHON]
"=============================================================================

" TODO: make these functions script-local?
function! PyFormat()
    set colorcolumn=80              " PEP-standard lines are 79 characters max
endfunction

augroup py_format
    au!
    autocmd BufEnter *.py               call PyFormat()
augroup end

"=============================================================================
"   Markdown Formatting                                     [MARKDOWN]
"=============================================================================

" Set Markdown specific formatting options.
function! MdFormat(should_format)
    call TextWrap(a:should_format)
endfunction

" Markdown Formatting
" .md files, .markdown files
 augroup md_format
    au!
    autocmd filetype markdown           call MdFormat(1)
augroup end


"=============================================================================
"   TeX Formatting                                          [TEX]
"=============================================================================
augroup tex_format
    au!
    autocmd filetype tex                call TextWrap(1)
    autocmd BufEnter *.tex              set filetype=tex
augroup end


"=============================================================================
"   AutoHotkey Formatting                                   [AUTOHOTKEY]
"=============================================================================

" Set AutoHotkey specific formatting options.
function! AhkFormat()
    set noexpandtab
endfunction

augroup ahk_format
    autocmd filetype autohotkey         call AhkFormat()
    autocmd BufEnter *.ahk              set filetype=autohotkey
    au!
augroup end

"=============================================================================
"   Snippets                                                [SNIPPETS]
"=============================================================================

augroup snippets_format
    au!
    autocmd filetype snippets           set expandtab
augroup end
