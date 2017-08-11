"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   Utility                                                 [UTILITY]
"   Convenience Macros                                      [MACRO]
"   Merge Conflict Resolution                               [MERGE_CONFLICT]
"   Folding                                                 [FOLDING]
"   Text Wrapping                                           [TEXT_WRAPPING]
"=============================================================================

"=============================================================================
"   Utility                                                 [UTILITY]
"=============================================================================

" EFFECTS:  Highlights in red all text going past 80 chars
function Highlight()
    " Highlight text going past 80 chars on one line
    highlight OverLength ctermbg=DarkRed ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endfunction

" EFFECTS:  Closes error windows opened by Syntastic or Neomake.
function CloseErrorWindows()
    " Closes quickfix list and locations list
    cclose
    lclose
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
function TestCaseAutoformat()
    if search("BOOST")
        " If I'm writing Boost test cases, format the function headers differently
        %s/BOOST_AUTO_TEST_CASE(\(.*\))/BOOST_AUTO_TEST_CASE(\1)\r{\r\tBOOST_TEST_MESSAGE("\1");\r\t\r\tBOOST_CHECK_MESSAGE(,"\1 failed!");\r}\r
    else
        " But, if I'm just writing generic test cases for a class,
        search("int main") " Don't reformat the forward declarations

        .,$s/void \(\<\w\+\>\)();\n/void \1()\r{\r\tcout << "\1" << endl;\r\r\tcout << "\1 PASSED" << endl;\r\}\r
    endif

    noh " stop highlighting matched function headers after the above call
endfunction

" EFFECTS:  Calls TestCaseAutoFormat().
function Tca()
    " Shorter alias for TestCaseAutoformat
    call TestCaseAutoformat()
endfunction

"=============================================================================
"   Merge Conflict Resolution                               [MERGE_CONFLICT]
"=============================================================================

function DiffgetLo()
    " filler is default and inserts empty lines for sync
    set diffopt=filler,context:1000000
    diffget LO
endfunction

function DiffgetRe()
    " filler is default and inserts empty lines for sync
    set diffopt=filler,context:1000000
    diffget RE
endfunction

function ExitMergeResolutionIfDone()
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
function RecursiveFoldPast(level)
    setlocal foldmethod=indent
    let &l:foldlevel = a:level
endfunction

" Fold everything indented at this level.
function FoldAt(level)
    let &l:foldnestmax=a:level + 1
    call RecursiveFoldPast(a:level)
    "%foldo
endfunction

" Write the current buffer and run Neomake's syntax checker.
" Also, stop vim from reclosing folds when Neomake shows the quickfix list.
function WriteAndLint()
    " setlocal foldmethod=manual
    w
    call CloseErrorWindows()
    Neomake
    " setlocal foldmethod=syntax
endfunction

" Fold all of the function implementations in the current file.
function FoldFunctionBodies()
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
function UnwrapAParagraph()
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
function UnwrapAll()
    " While there are unwrapped paragraphs, UnwrapAParagraph.
    while UnwrapAParagraph()
    endwhile
    echo "Unwrapped all lines in file."
endfunction

function YankUnwrapped()
    call UnwrapAll()
    normal! ggVG"+yu
    echo "Unwrapped paragraphs yanked to clipboard."
endfunction

" Wrap all text
function WrapAll()
    normal! ggVGgqq
    echo "Hard-wrapped all lines in file."
endfunction

" Set text wrapping value.
function TextWrap(should_format)
    if a:should_format==?1
        " Text wrapping
        set textwidth=75                " Hard line breaks, with newline chars
    else
        set textwidth=0                 " Disable text wrapping
    endif
endfunction