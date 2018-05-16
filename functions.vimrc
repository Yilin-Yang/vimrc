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
"=============================================================================

"=============================================================================
"   Utility                                                 [UTILITY]
"=============================================================================

" EFFECTS:  Open the given helpdoc in a vertical split.
command! -nargs=1 H execute ":vert h <args>"

" EFFECTS:  Opens the given file and jumps to the given line.
" PARAM:    filename (string)   The filepath to the target file.
" PARAM:    lineno (string)     The target line number in the target file.
function! Goto(filename, lineno)
    execute "normal! :e " . a:filename . " | " . a:lineno . "\<cr>"
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
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
command! -nargs=+ -complete=command BufDoAll call BufDoAll(<q-args>)

" EFFECTS:  Deletes all trailing whitespace in the active file, returning
"           the cursor to its old location afterwards.
function! DeleteTrailing()
    let cols_from_left = getpos(".")[2] - 1
    let lines_from_top = line(".")
    %s/\s\+$//e
    execute 'normal! ' . eval(lines_from_top) . 'G' . '0' . eval(cols_from_left) . 'l'
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


" EFFECTS:  Given the function headers for Boost test cases, add curly braces,
"           a print statement giving the name of the test, and a
"           BOOST_CHECK_MESSAGE call before the end of the function.
"
"           Given the function prototypes for EECS280 style test cases, remove
"           the semicolon, add curly braces, add a print statement giving the
"           name of the test, and a print statement reporting test success.
function! TestCaseAutoformat()
    if search("BOOST")
        " If I'm writing Boost test cases, format the function headers differently
        %s/BOOST_AUTO_TEST_CASE(\(.*\))/BOOST_AUTO_TEST_CASE(\1)\r{\r\tBOOST_TEST_MESSAGE("\1");\r\t\r\tBOOST_CHECK_MESSAGE(, "\1 failed!");\r}\r
    else
        " But, if I'm just writing generic test cases for a class,
        call search("int main")

        .,$s/void \(\<\w\+\>\)();\n/void \1()\r{\r\tcout << "\1" << endl;\r\r\tcout << "\1 PASSED" << endl;\r\}\r\r
        normal! dk
    endif

    retab
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
    if search("<<<<<<<") || search(">>>>>>>")
        echoerr "Still conflicts to resolve!"
    else
        wq | qa
    endif
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
        let filename = expand('%:t')
        if match(filename, "hpp$") !=? -1 || match(filename, "h$") !=? -1
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
    let lineno=search('\(^[^\n\r]\+\n\)\{2,}')
    "                    ^ from the start of the line,
    "                      ^ a character that isn't a newline char
    "                             ^ one or more times
    "                               ^ to the end of the line
    "                                   ^ matching that block two or more times
    normal! vipJ
    " ^ press these keys in normal mode, ignoring any existing keymappings

    return lineno
endfunction

" Unwrap all text
function! UnwrapAll()
    " While there are unwrapped paragraphs, UnwrapAParagraph.
    while UnwrapAParagraph()
    endwhile
    echo "Unwrapped all lines in file."
endfunction

function! YankUnwrapped()
    call UnwrapAll()
    normal! ggVG"+yu
    echo "Unwrapped paragraphs yanked to clipboard."
endfunction

" Wrap all text
function! WrapAll()
    normal! ggVGgqq
    echo "Hard-wrapped all lines in file."
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
"               change (string)         Formatted like '+5' or '-3'. Used
"                                           for incrementing/decrementing by
"                                           an absolute number of
"                                           rows/cols.
"               change (float)          The window's new size, as a proportion
"                                           of vim's current displayable area.
function! ResizeSplit(dimension, change)
    let l:command = "normal! :"  " build a resize command piece by piece
    if type(a:change) == v:t_string
        let l:change = a:change
    else
        let l:change = string(a:change)
    endif

    if a:dimension ==# 'WIDTH'
        let l:command = l:command . "vertical resize "
    elseif a:dimension ==# 'HEIGHT'
        let l:command = l:command . "resize "
    endif

    let l:match = matchstr(l:change, '^[+-]')
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
    let a:start     = get(a:, 1, 0)
    let a:end       = get(a:, 2, 255)
    let a:hi_args   = get(a:, 3, '')

    if a:start ==# 0
        echoerr "No args provided to ColorColumnBlock!"
        return
    endif

    if strlen(a:hi_args)
        execute 'hi ColorColumn ' . a:hi_args
    endif
    execute 'set colorcolumn=' . join(range(a:start,a:end), ',')
endfunction
