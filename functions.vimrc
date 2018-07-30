"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   Utility                                                 [UTILITY]
"   ctags                                                   [CTAGS]
"   Convenience Macros                                      [MACRO]
"   Merge Conflict Resolution                               [MERGE_CONFLICT]
"   Folding                                                 [FOLDING]
"   Text Wrapping                                           [TEXT_WRAPPING]
"   Window Resizing                                         [WINDOW_RESIZE]
"   Cosmetic                                                [COSMETIC]
"   Code Style                                              [STYLE]
"=============================================================================

"=============================================================================
"   Utility                                                 [UTILITY]
"=============================================================================

" EFFECTS:  Open the given helpdoc in a vertical split.
command! -nargs=1 H execute ':vert h <args>'

" EFFECTS:  Opens the given file and jumps to the given line.
" PARAM:    filename (string)   The filepath to the target file.
" PARAM:    lineno (string)     The target line number in the target file.
function! Goto(filename, lineno)
    execute 'normal! :e ' . a:filename . ' | ' . a:lineno . '\<cr>'
endfunction()
command! -nargs=+ -complete=file Gt call Goto(<f-args>)

" EFFECTS:  Highlights in red all text going past 80 chars
function! Highlight()
    " Highlight text going past 80 chars on one line
    highlight OverLength ctermbg=DarkRed ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endfunction

" EFFECTS:  Closes error windows opened by Syntastic or Neomake.
function! CloseErrorWindows()
    " Closes quickfix list and locations list
    cclose
    lclose
endfunction

" EFFECTS:  Executes the given command in all active buffers.
"           When finished, go back to the buffer from which the command
"           was executed.
"
" USAGE:        call BufDoAll({arg})                <cr>
"               BufDoAll {arg1} {arg2} {arg3}...    <cr>
"
"           Note that, when executing a search-and-replace, you should
"           follow this format:
"
"               BufDoAll s:replaceMe:withThisText:ge | update
"
"           The option `e` in the call to `s` tells vim to ignore errors
"           (i.e. from not finding 'replaceMe' in a given buffer.)
"
"           `| update` tells vim to write any changes that were made, if
"           there were any. This stops vim's complaints that it can't abandon
"           the current buffer since the buffer has unsaved changes.
"
" CREDIT:   Taken from:
"               http://vim.wikia.com/wiki/Run_a_command_in_multiple_buffers
"
function! BufDoAll(command)
  let l:curr_buff = bufnr('%')
  execute 'bufdo ' . a:command
  execute 'buffer ' . l:curr_buff
endfunction
command! -nargs=+ -complete=command BufDoAll call BufDoAll(<q-args>)

" EFFECTS:  Deletes all trailing whitespace in the active file, returning
"           the cursor to its old location afterwards.
function! DeleteTrailing()
    let l:old_contents = @"
    let l:old_search = @/

    let l:cols_from_left = getpos('.')[2] - 1
    let l:lines_from_top = line('.')
    %s/\s\+$//e

    execute 'normal! ' . eval(l:lines_from_top) . 'G' . '0' . eval(l:cols_from_left) . 'l'
    let @/ = l:old_search
    let @" = l:old_contents
endfunction

" EFFECTS:  Centers the text on the given line, surrounding it with a given
"           character.
" PARAM:    char (v:t_string)   The comment character with which the pad the
"                                   the centered text. Shall be one character
"                                   in length.
function! CenterTextAndPad(char)

    " Calculate a 'linewidth' from colorcolumn, if necessary.
    let l:linewidth = &textwidth
    if l:linewidth ==# 0
        let l:linewidth = split(&colorcolumn, ',')[0] - 1
    endif

    if strlen(a:char) !=# 1
        echoerr 'Comment character must have length 1!'
        return
    endif

    if strwidth(getline('.')) ># l:linewidth
        echoerr 'Line too long for centering.'
        return
    endif

    " Avoid clobbering `expandtab`, unnamed register.
    let l:cur_indent = &expandtab
    let l:old_contents = @"

    setlocal expandtab
    center
    execute 'normal! 2hv0' . 'r' . a:char . 'viwy'
    call setline('.', getline('.') . ' ')

    while strwidth(getline('.')) <# l:linewidth
        call setline('.', getline('.') . a:char)
    endwhile

    if l:cur_indent | setlocal expandtab | endif
    let @" = l:old_contents

endfunction

command! -nargs=1 CenterTextAndPad call CenterTextAndPad(<args>)

" EFFECTS:  Redirects the output of the given vim command into a
"           scratch buffer.
" USAGE:    :Redir hi ............. show the full output of command ':hi' in a
"                                   scratch window
"           :Redir !ls -al ........ show the full output of command ':!ls -al'
"                                   in a scratch window
" DETAILS:  Taken from:
"               https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! Redir(cmd)
    for l:win in range(1, winnr('$'))
        if getwinvar(l:win, 'scratch')
            execute l:win . 'windo close'
        endif
    endfor
    if a:cmd =~# '^!'
        execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
    else
        redir => l:output
        execute a:cmd
        redir end
    endif
    vnew
    let w:scratch = 1
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(l:output, "\n"))
endfunction

command! -nargs=1 Redir silent call Redir(<f-args>)

" EFFECTS:  Counts the total number of times that the given search pattern
"           occurs in the given range `[a:start, a:end]`.
" DETAILS:  Adapted from:
"               https://vi.stackexchange.com/a/6984
function! Count(start, end, pattern) abort
    redir => l:count
        silent execute a:start.','.a:end.'s/' . a:pattern . '//gn'
    redir end
    return strpart(l:count, 0, stridx(l:count, " "))
endfunction

"=============================================================================
"   ctags                                                   [CTAGS]
"=============================================================================

" EFFECTS: Runs ctags recursively on all files and directories in the PWD.
function! UpdateGlobalTags()
    let l:already_on = 0

    " If autorecursion is on, note that; if not, turn it on.
    g:easytags_autorecurse ? let l:already_on = 1 : let g:easytags_autorecurse = 1

    execute "normal! :UpdateTags\<cr>"

    " Turn autorecursion off it wasn't on originally.
    l:already_on ? return : let g:easytags_autorecurse = 0
endfunction

"=============================================================================
"   Convenience Macros                                      [MACRO]
"=============================================================================


" EFFECTS:  Given the function prototypes for EECS280 style test cases, remove
"           the semicolon, add curly braces, add a print statement giving the
"           name of the test, and a print statement reporting test success.
function! TestCaseAutoformat()
    let l:old_contents = @"
    let l:old_search = @/

    if match(&filetype, 'cpp') !=# -1
        call search('int main')
        .,$s/void \(\<\w\+\>\)();\n/void \1()\r{\r\tcout << "\1" << endl;\r\r\tcout << "\1 PASSED" << endl;\r\}\r\r
        normal! dk
    elseif match(&filetype, 'c') !=# -1
        call search('int main')
        .,$s/void \(\<\w\+\>\)();\n/void \1()\r{\r\tprintf("\1\\n");\r\r\tprintf("\1 PASSED\\n");\r\}\r\r
    endif

    retab

    let @/ = l:old_search
    let @" = l:old_contents

    noh " stop highlighting matched function headers after the above call
endfunction
command! -nargs=0 Tca call TestCaseAutoformat()

"=============================================================================
"   Merge Conflict Resolution                               [MERGE_CONFLICT]
"=============================================================================

function! DiffgetLo()
    " filler is default and inserts empty lines for sync
    set diffopt=filler,context:1000000
    diffget LO
endfunction

function! DiffgetRe()
    " filler is default and inserts empty lines for sync
    set diffopt=filler,context:1000000
    diffget RE
endfunction

function! ExitMergeResolutionIfDone()
    if search('<<<<<<<') || search('>>>>>>>')
        echoerr 'Still conflicts to resolve!'
    else
        wall | qall
    endif
endfunction

" EFFECTS:  Returns true if 'whiteinge/diffconflicts' is active (i.e. if the
"           active vim instance was launched as a git mergetool), false
"           otherwise.
function! DiffconflictsActive()
    let l:old_contents = @"

    " Detect if there are active buffers that contain BASE, LOCAL, or REMOTE
    " in their names.
    redir @" | silent buffers | redir end
    if len(matchstr(@", '_BASE_'))
        \ && len(matchstr(@", '_LOCAL_'))
        \ && len(matchstr(@", '_REMOTE_'))

        let l:to_return = 1
    else
        let l:to_return = 0
    endif

    let @" = l:old_contents
    return l:to_return
endfunction

"=============================================================================
"   Folding                                                 [FOLDING]
"=============================================================================

" Fold everything indented past this fold-level.
function! RecursiveFoldPast(level)
    setlocal foldmethod=indent
    let &l:foldlevel = a:level
endfunction

" Fold everything indented at this level.
function! FoldAt(level)
    let &l:foldnestmax=a:level + 1
    call RecursiveFoldPast(a:level)
    "%foldo
endfunction

" Write the current buffer and run Neomake's syntax checker.
" Also, stop vim from reclosing folds when Neomake shows the quickfix list.
function! WriteAndLint()
    " setlocal foldmethod=manual
    w
    call CloseErrorWindows()
    Neomake
    " setlocal foldmethod=syntax
endfunction

" Fold all of the function implementations in the current file.
function! FoldFunctionBodies()
    setlocal foldmethod=indent
    if &foldlevel !=? 20
        setlocal foldlevel=20
    else
        " Expand the name of just this file, see what filetype it is
        let l:filename = expand('%:t')
        if match(l:filename, 'hpp$') !=? -1 || match(l:filename, 'h$') !=? -1
            setlocal foldlevel=1
        else
            setlocal foldlevel=0
        endif
        let l:foldnestmax=&foldlevel + 1
    endif
endfunction

"=============================================================================
"   Text Wrapping                                           [TEXT_WRAPPING]
"=============================================================================

" Searches for the next multiline paragraph and unwraps it.
" Returns the line number of the multiline paragraph, or zero if one wasn't
" found.
function! UnwrapAParagraph()
    let l:lineno = search('\(^[^\n\r]\+\n\)\{2,}')
    "                    ^ from the start of the line,
    "                      ^ a character that isn't a newline char
    "                             ^ one or more times
    "                               ^ to the end of the line
    "                                   ^ matching that block two or more times
    normal! vipJ
    " ^ press these keys in normal mode, ignoring any existing keymappings

    return l:lineno
endfunction

" Unwrap all text
function! UnwrapAll()
    " While there are unwrapped paragraphs, UnwrapAParagraph.
    while UnwrapAParagraph()
    endwhile
    echo 'Unwrapped all lines in file.'
endfunction

function! YankUnwrapped()
    call UnwrapAll()
    normal! ggVG"+yu
    echo 'Unwrapped paragraphs yanked to clipboard.'
endfunction

" Wrap all text
function! WrapAll()
    normal! ggVGgqq
    echo 'Hard-wrapped all lines in file.'
endfunction

" Set text wrapping value.
function! TextWrap(should_format)
    if a:should_format==?1
        " Text wrapping
        set textwidth=80                " Hard line breaks, with newline chars
    else
        set textwidth=0                 " Disable text wrapping
    endif
endfunction

"=============================================================================
"   Window Resizing                                         [WINDOW_RESIZE]
"=============================================================================

" EFFECTS:  Resizes the active split, along a given direction, to a provided
"           size proportional to its current size OR by incrementing/decrementing
"           by an absolute number of rows/cols.
" PARAM:    dimension (string)  Whether to change the split's width or its
"           height. Valid values are 'WIDTH' and 'HEIGHT'.
" PARAM:    change (string OR float)    How much to change the window's size.
"               change (string)         Formatted like '+5' or '-3', *with
"                                           quotes.* Used for
"                                           incrementing/decrementing by an
"                                           absolute number of rows/cols.
"               change (float)          The window's new size, as a proportion
"                                           of vim's current displayable area.
function! ResizeSplit(dimension, change)
    let l:command = 'normal! :'  " build a resize command piece by piece
    if type(a:change) == v:t_string
        let l:change = a:change
    else
        let l:change = string(a:change)
    endif

    if a:dimension ==# 'WIDTH'
        let l:command = l:command . 'vertical resize '
    elseif a:dimension ==# 'HEIGHT'
        let l:command = l:command . 'resize '
    endif

    let l:match = matchstr(l:change, '[+-]')
    if l:match ==# '+' || l:match ==# '-'
        " Regex match detected a plus or minus at the start of the variable,
        " so we're incrementing/decrementing absolutely.
        let l:command = l:command . l:change
    else
        " Assume we were given a floating point proportion.

        if a:dimension ==# 'WIDTH'
            let l:new_size = string(&columns * a:change)
        elseif a:dimension ==# 'HEIGHT'
            let l:new_size = string(&lines * a:change)
        endif
            let l:command = l:command . l:new_size
    endif

    let l:command = l:command . "\<cr>"
    echo l:command

    execute l:command
endfunction

" Resize split to a proportion of its size.
command! -nargs=1 Rs   call ResizeSplit('HEIGHT', <args>)
command! -nargs=1 Vrs  call ResizeSplit('WIDTH', <args>)

"=============================================================================
"   Cosmetic                                                [COSMETIC]
"=============================================================================

" EFFECTS:  Sets a colorcolumn for every column in the specified range
"           (`[start, end]`) OR every column from `start`
"           onwards (`[start, +inf)`).
" PARAM:    start (v:t_number)      The first column to highlight.
" PARAM:    end (v:t_number)        The last column to highlight (inclusive).
"                                       Defaults to +inf (actually 255, which
"                                       is the maximum possible value in vim.)
" PARAM:    hi_args (v:t_string)    The highlight arguments to be applied to
"                                       the ColorColumn highlight group
"                                       (e.g. `ctermg=1 guibg=DarkRed`). Set
"                                       to the null string (`''`) by default,
"                                       which leaves ColorColumn unchanged
"                                       from its present value.
" DETAIL:   Taken from the following link:
"               https://blog.hanschen.org/2012/10/24/different-background-color-in-vim-past-80-columns/
function! ColorColumnBlock(...)
    let a:num_args  = get(a:, 0)
    let a:start     = get(a:, 1, 0)
    let a:end       = get(a:, 2, 255)
    let a:hi_args   = get(a:, 3, '')

    if a:num_args ==# 0
        echoerr 'No args provided to ColorColumnBlock!'
        return
    endif

    if strlen(a:hi_args)
        execute 'hi ColorColumn ' . a:hi_args
    endif
    execute 'set colorcolumn=' . join(range(a:start,a:end), ',')
endfunction

"=============================================================================
"   Code Style                                              [STYLE]
"=============================================================================

" EFFECTS:  Tries to reformat the current file to comply with Yilin's personal
"           style preferences.
" DETAIL:   As of the time of writing (2018-06-14), 'Yilin style' consists of:
"           +  Allman style brace placement (i.e. curly brace on next line).
"           +  Spaces for indentation instead of tabs.
"           +* At least one space of 'breathing room' on both sides of
"           operators (arithmetic, logical, etc.), not counting special cases
"           like `operator[]` or `operator->`.
"           - Snakecase variables, camelcase classes/structs/functions/etc.
"
"           `+` denotes a style component that this function tries to fix.
" PARAM:    breathing_room (v:t_bool)   Whether or not to add 'breathing room'
"                                           with an interactive substitution
"                                           command. Defaults to `false`.
function! AutoYilinStyle(...)
    let a:breathing_room = get(a:, 1, 0)

    if match(&filetype, 'cpp') ==# -1 && match(&filetype, 'c') ==# -1
        echoerr 'AutoYilinStyle expects C/C++ files.'
        return
    endif

    let l:cur_line = line('.')

    " Callee-save unnamed register, search register.
    let l:old_contents = @"
    let l:old_search   = @/

    " unsquish control statements
    %s:\m\(\s\)\+\(if\|else\|for\|while\|case\|switch\)(:\1\2 (:e

    " remove kernighan and ritchie from premises
    %s:\m}\s*\(else if\|else\|if\):}\r\1:e
    %s:\m\(\S\)\s*{:\1\r{:e

    " (Optionally) add breathing room.
    if a:breathing_room
        %s:\m\(\S\)\([-+/*=!]=\|=\|+\|-\|*\|<<\|>>\|<\|>\|?\)\(\S\):\1 \2 \3:gce
    endif

    let @/ = l:old_search
    let @" = l:old_contents
    execute 'normal! ' . l:cur_line . 'G'

endfunction

" EFFECTS:  Returns a string containing the user's 'indentation block,' i.e. a
"           literal tab character if the user indents with tabs, or '    '
"           (four spaces) if the user indents with four spaces for every
"           press of the <Tab> key.
" DETAIL:   In the event of 'conflict' between indentation settings (e.g. if
"           &shiftwidth is less than &tabstop), GetIndentStyle will return the
"           smallest nonzero value.
"
"           If &softtabstop is set, GetIndentStyle will prefer it value over the
"           value of &tabstop.
function! GetIndentStyle()
    let l:indent_block = '' " string to return

    let l:space_indent = 0

    " determine the user's indentation style
    if &expandtab
        let l:space_indent = 1
    else " noexpandtab
        if &softtabstop && &softtabstop <# &tabstop
            let l:space_indent = 1
        else
            let l:space_indent = 0
        endif
    endif

    "
    if l:space_indent ==# 0 | return "\t" | endif

    " calculate indentation width

    " " prefer the value of softtabstop over tabstop, if set
    let l:tab_stop = (&softtabstop) ? &softtabstop : &tabstop
    let l:tab_stop = (&softtabstop ==# -1) ? &shiftwidth : l:tab_stop

    " " handle edge case when shiftwidth is zero
    let l:shift_width = (&shiftwidth) ? &shiftwidth : l:tab_stop

    " " calculated width
    let l:block_width = (&expandtab) ? l:tab_stop : min([&shiftwidth, l:tab_stop])

    if l:block_width <# 0
        echoerr 'GetIndentStyle: calculated indent block size is negative? '
            \ . '(Calculated indentation width: ' . string(l:block_width) . ')'
        return
    endif

    while strlen(l:indent_block) <# l:block_width
        let l:indent_block .= ' '
    endwhile

    return l:indent_block
endfunction

" REQUIRES: - It is suggested that the current file be a C/C++ file.
"           - Given file has already been `retab`d to this user's preferred
"           indentation style.
" EFFECTS:  Reformats parenthesis-enclosed (`(...[etc.]...)`) text as follows:
"               int foo(int bar, double boo, string gar);
"
"               // converts to...
"
"               int foo(
"                   int bar,
"                   double boo,
"                   string gar
"               );
" NOTES:    Function takes in a range (see `:help func-range`).
" PARAM:    continuation_character      (v:t_string)
"                                       The character to prepend onto the
"                                       start of each newly created line.
"                                       Defaults to a nullstring.
function! ReformatMultilineParentheses(...) range abort
    let a:num_args = get(a:, 0)
    let a:continuation_character = a:num_args ? get(a:, 1) : ''

    " Callee-save unnamed register, search register.
    let l:old_contents = @"
    let l:old_search   = @/

    " Clear equalprg.
    let l:equalprg = &equalprg
    set equalprg=

    " Set cinoptions appropriately.
    let l:cinoptions = &cinoptions
    set cinoptions=
    set cinoptions=L-1,:0,g0,+0,N0,t0,(0,Ws,m1

    let l:buflen_start = line('$')

    " arbitrary string that should never reasonably appear in a normal file
    let l:marker = '😍😉😃😂😍😮🙄😢😬🤑'

    " search pattern for function headers, function calls that are broken
    " across multiple lines.
    let l:search_pattern = '\m^[ \t]\{-}[a-zA-Z].\{-}\S([)]\@!'

    " Break after the opening parenthesis.
    execute 'silent '.a:firstline.','.a:lastline
        \ . 'g:'.l:search_pattern.':s/'.l:search_pattern.'/&\r'.l:marker

    let l:lastline = a:lastline + line('$') - l:buflen_start

    " Break just before the closing parenthesis.
    execute 'silent '.a:firstline.','.l:lastline
        \ . 'g:'.l:marker.':s/\m)[\s;]\{-}$/\r&/e'

    let l:lastline = a:lastline + line('$') - l:buflen_start

    execute 'silent '.a:firstline.','.l:lastline
        \ . 'g:'.l:marker.':s/\m, \+/'.a:continuation_character.'&\r/ge'

    let l:lastline = a:lastline + line('$') - l:buflen_start

    " delete the marker
    execute 'silent '.'silent %s/'.l:marker.'//ge'

    " NOTE: substitution command adds new lines to the file, so recalculate
    "       the value of a:lastline
    let l:buflen_end = line('$')
    let l:num_new    = l:buflen_end - l:buflen_start
    let l:lastline   = a:lastline + l:num_new

    " Filter given range through `=` operator.
    execute 'silent '.'normal! ' . a:firstline . 'GV' . l:lastline . 'G='

    " Restore old values.
    let &cinoptions=l:cinoptions
    let &equalprg=l:equalprg

    let @/ = l:old_search
    let @" = l:old_contents
endfunction
