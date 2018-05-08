"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   C++ Formatting                                          [CPP]
"   C Formatting                                            [C_LANG]
"   Python Formatting                                       [PYTHON]
"   Markdown Formatting                                     [MARKDOWN]
"   AutoHotkey Formatting                                   [AUTOHOTKEY]
"   TeX Formatting                                          [TEX]
"   Snippets                                                [SNIPPETS]
"   YAML Formatting                                         [YAML]
"   Prose Formatting                                        [PROSE]
"   Assembly Formatting                                     [ASSEMBLY]
"   Makefile Settings                                       [MAKEFILE]
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
"   C Formatting                                            [C_LANG]
"=============================================================================

function! CFormat()
    setlocal colorcolumn=81
    set filetype=c.doxygen
endfunction

augroup c_format
    au!
    autocmd BufRead *.c     call CFormat()
    autocmd BufRead *.h     call CFormat()
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
"   Markdown Formatting                                     [MARKDOWN]
"=============================================================================

function! MdFormat()
    setlocal shiftwidth=2
endfunction

augroup md_format
    au!
    autocmd FileType markdown   call MdFormat()
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

"=============================================================================
"   Prose Formatting                                        [PROSE]
"=============================================================================

" EFFECTS:  Configures the local buffer for writing/editing prose.
" REQUIRES: reedes/vim-pencil
"           reedes/vim-lexical
"           reedes/vim-textobj-sentence
"           reedes/vim-wordy
"
" DETAIL:   Adapted from:
"               https://github.com/reedes/vim-pencil
function! Prose()
  call pencil#init()
  call lexical#init()
  call textobj#sentence#init()
endfunction


" EFFECTS:  Enables abbreviations for 'hard-to-type' punctuation marks.
" DETAIL:   Adapted from:
"               https://github.com/reedes/vim-pencil
function! Punctuation()
  " replace common punctuation
  iabbrev <buffer> --   –
  iabbrev <buffer> ---  —
  iabbrev <buffer> <<   «
  iabbrev <buffer> >>   »
endfunction

"=============================================================================
"   Assembly Formatting                                     [ASSEMBLY]
"=============================================================================

function! AssemblyFormat()
    setlocal shiftwidth=8
    setlocal tabstop=8
    setlocal expandtab
endfunction

augroup assembly_format
    au!
    autocmd BufRead *.as    set filetype=asm
    autocmd FileType asm    call AssemblyFormat()
augroup end

"=============================================================================
"   Makefile Settings                                       [MAKEFILE]
"=============================================================================

function! MakefileSettings()
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal noexpandtab
endfunction

augroup makefile_settings
    au!
    autocmd filetype make   call MakefileSettings()
augroup end
