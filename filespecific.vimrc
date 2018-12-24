scriptencoding utf-8
"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   C/C++ Formatting                                        [C_CPP]
"   Prose Formatting                                        [PROSE]
"   Startup Settings                                        [STARTUP]
"=============================================================================

"=============================================================================
"   C/C++ Formatting                                        [C_CPP]
"=============================================================================

" BRIEF:    Set indentation options for C/C++.
" DETAILS:  See `:help cinoptions-values` for more information. 'Starts in
"           column 1' means that the given item will have exactly zero
"           indentation.
" LEGEND:   (changes from default, which are given in `:h cinoptions`)
"   L-1 :   Place jump labels (for `goto` statements) in column 1.
"   :0  :   Zero additional indentation after `switch` statements.
"   g0  :   Scope declarations (`public`, `private`, etc.) go in column 1.
"   +2s :   Continuation lines receive an additional indentation relative to
"           the previous line of `2 * shiftwidth`.
"   N0  :   Zero additional indentation for code inside namespaces.
"   t0  :   Function return types go in column 1, if they're on another line.
"   (0  :   No additional indentation for multiline if statements.
"   W2s :   When breaking apart unclosed parentheses across multiple lines
"           (e.g. a multiline function call), indent by `2 * shiftwidth`.
"   m1  :   Lines that start with closing parentheses are aligned with the
"           first character of the line with the matching opening parentheses.
function! CPPIndent()
    setlocal cinoptions+=L-1,:0,g0,+2s,N0,t0,(0,W2s,m1
endfunction

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
