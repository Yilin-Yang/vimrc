"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   C/C++ Formatting                                        [C_CPP]
"   Python Formatting                                       [PYTHON]
"   Shell Script Formatting                                 [SH]
"   Markdown Formatting                                     [MARKDOWN]
"   AutoHotkey Formatting                                   [AUTOHOTKEY]
"   TeX Formatting                                          [TEX]
"   Snippets                                                [SNIPPETS]
"   YAML Formatting                                         [YAML]
"   Prose Formatting                                        [PROSE]
"   Assembly Formatting                                     [ASSEMBLY]
"   Makefile Settings                                       [MAKEFILE]
"   Git Settings                                            [GIT]
"   vimwiki Settings                                        [VIMWIKI]
"   Startup Settings                                        [STARTUP]
"=============================================================================

"=============================================================================
"   C/C++ Formatting                                        [C_CPP]
"=============================================================================

" Set indentation options for C/C++.
" See `:help cinoptions-values` for more information. 'Starts in column 1'
"   means that the given item will have exactly zero indentation.
" LEGEND: (changes from default, which are given in `:h cinoptions`)
"   L-1 :   Place jump labels in column 1.
"   :0  :   Zero additional indentation after `switch` statements.
"   g0  :   Scope declarations (`public`, `private`, etc.) go in column 1.
"   +0  :   Continuation lines receive no additional indentation relative to
"               the previous line.
"   N0  :   Zero additional indentation for code inside namespaces.
"   t0  :   Function return types go in column 1, if they're on another line.
"   (0  :   No additional indentation for multiline if statements.
"   Ws  :   When breaking apart unclosed parentheses across multiple lines
"           (e.g. a multiline function call), indent by `shiftwidth`.
"   m1  :   Lines that start with closing parentheses are aligned with the
"           first character of the line with the matching opening parentheses.

set cinoptions+=L-1,:0,g0,+0,N0,t0,(0,Ws,m1

" Set C++ specific formatting options.
function! CppFormat()
    call ColorColumnBlock(81)       " My personal line limit
    set filetype=cpp.doxygen        " And highlight doxygen formatting
    nnoremap <buffer> <silent> <leader>e :call CenterTextAndPad('/')<cr>
endfunction

" C++ Formatting
" .cpp files
 augroup cpp_format
    au!
    autocmd BufWinEnter *.cpp   call CppFormat()
    autocmd BufWinEnter *.hpp   call CppFormat()
 augroup end


function! CFormat()
    call ColorColumnBlock(81)
    set filetype=c.doxygen
    nnoremap <buffer> <silent> <leader>e :call CenterTextAndPad('/')<cr>
endfunction

" EFFECTS:  Determine whether the file is a C++ or a C header and call the
"           appropriate formatting function.
function! DetermineCppHeaderFormat()
    let l:line_no =
        \ search(
            \ '\(namespace\)\|\(class\)\|\(public\)\|\(private\)\|\(protected\)',
            \ 'ncw')
    if l:line_no
        call CppFormat()
    else
        call CFormat()
    endif
endfunction


augroup c_format
    au!
    autocmd BufWinEnter *.c     call CFormat()
    autocmd BufWinEnter *.h     call DetermineCppHeaderFormat()
augroup end

"=============================================================================
"   Python Formatting                                       [PYTHON]
"=============================================================================

function! PyFormat()
    call ColorColumnBlock(80)       " PEP-standard lines are 79 characters max
endfunction

augroup py_format
    au!
    autocmd BufWinEnter *.py    call PyFormat()
augroup end

"=============================================================================
"   Shell Script Formatting                                 [SH]
"=============================================================================

function! ShellScriptFormat()
    call ColorColumnBlock(81)
    nnoremap <buffer> <silent> <leader>e :call CenterTextAndPad('#')<cr>
endfunction()

augroup sh_format
    au!
    autocmd FileType sh         call ShellScriptFormat()
augroup end

"=============================================================================
"   Markdown Formatting                                     [MARKDOWN]
"=============================================================================

" Enable fold-by-heading-level in Markdown.
" Taken from:
"   https://vi.stackexchange.com/a/9544
let g:markdown_folding = 1

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
    silent! iunmap <leader>`
    silent! iunmap <leader>'
endfunction

augroup tex_format
    au!
    autocmd filetype tex        call TeXFormat()
    autocmd BufWinEnter *.tex   set filetype=tex
    autocmd BufLeave *.tex      call TeXUnformat()
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
    autocmd BufWinEnter *.ahk   set filetype=autohotkey
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
    nnoremap <buffer> <silent> <leader>e :call CenterTextAndPad('#')<cr>
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
    setlocal noexpandtab        " appropriate to use standard tabs, here
endfunction

augroup assembly_format
    au!
    autocmd BufWinEnter *.as    set filetype=asm
    autocmd FileType asm        call AssemblyFormat()
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
    autocmd filetype make       call MakefileSettings()
augroup end

"=============================================================================
"   Git Settings                                            [GIT]
"=============================================================================

function! GitCommitSettings()
    augroup git_colorcolumn
        au!
        " Subject line is <= 50 characters long.
        " Body is <= 72 characters wide.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained
            \ <buffer>
            \ execute 'call ColorColumnBlock(' . ( line('.') ==# 1 ? '51)' : '73)' )
    augroup end
endfunction

augroup gitcommit_format
    au!
    autocmd filetype gitcommit  call GitCommitSettings()
augroup end


"=============================================================================
"   vimwiki Settings                                        [VIMWIKI]
"=============================================================================

function! VimwikiFormat()
    if (&filetype !=# 'vimwiki')
        set filetype=vimwiki
    endif
    if has_key(g:plugs, 'vim-pencil')
        " HardPencil borks some of vimwiki's list-editing commands.
        NoPencil
    endif
    " Kill vimwiki's default <Tab> bindings, which break my completion menu.
    silent! iunmap <buffer> <expr> <Tab>
    set syntax=markdown
    setlocal nocursorline
endfunction

augroup vimwiki_format
    au!
    autocmd filetype vimwiki    call VimwikiFormat()
augroup end

"=============================================================================
"   Startup Settings                                        [STARTUP]
"=============================================================================

" Disable spellchecking when running a vimdiff, to prevent overlapping
" highlighting making text unreadable.
function! StartupSettings()
    if &diff
        set nospell
    else
    endif
endfunction

augroup startup_settings
    au!
    autocmd VimEnter *      call StartupSettings()
augroup end
