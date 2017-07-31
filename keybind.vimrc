"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   Ordinary                                                [ORDINARY]
"   System                                                  [SYSTEM]
"   Functions                                               [FUNCTIONS]
"   Split Navigation                                        [SPLITS]
"   Merge Conflicts                                         [MERGE_CONFLICTS]
"=============================================================================

"=============================================================================
"   Ordinary                                                [ORDINARY]
"=============================================================================

" Exit interactive/visual mode by hitting j and k
inoremap jk <esc>
vnoremap jk <esc>

if has('nvim')
    " nvim specific, not needed for vim
    " Map j and k to exiting terminal mode
    tnoremap jk <C-\><C-n>

    " Ditto with ESC
    tnoremap <Esc> <C-\><C-n>

    " Control plus HJKL to move between windows in terminal mode
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l
else
    " vim specific, not needed for nvim

    " Enable use of Alt key as modifier (sends Escape character)
    execute "set <M-d>=\ed"
    execute "set <M-a>=\ea"
endif

" Tabs
    " Alt + A/D to move through tabs
    nnoremap <M-a> :tabp<cr>
    nnoremap <M-d> :tabn<cr>

    " Alt + J/K to move through tabs
    nnoremap <M-j> :tabp<cr>
    nnoremap <M-k> :tabn<cr>

    " Alt + N/C to open/close tabs
    nnoremap <M-n> :tabnew<cr>:NERDTreeToggle<cr>
    nnoremap <M-c> :tabclose<cr>

    " Alt + H to clear highlights and error windows
    nnoremap <M-h> :call CloseErrorWindows()<cr>:noh<cr>:echo "Cleared highlights."<cr>

    " Number row zero and +/- to open and close tabs
    nnoremap 0= :tabnew<cr>:NERDTreeToggle<cr>
    nnoremap 0- :tabclose<cr>

"=============================================================================
"   System                                                  [SYSTEM]
"=============================================================================

" Enable paste-mode that doesn't autotab
set pastetoggle=<F2>


"=============================================================================
"   Functions                                               [FUNCTIONS]
"=============================================================================

" Function Key Toggles
"   Toggle Fold
    nnoremap <F5> :call FoldFunctionBodies()<cr>

"   Wrap/Unwrap Lines
    nnoremap <F3> :call WrapAll()<cr>
    nnoremap <F4> :call UnwrapAll()<cr>

"=============================================================================
"   Split Navigation                                        [SPLITS]
"=============================================================================

" Ctrl + hjkl to cycle through windows!
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-\><C-N><C-w>hi
inoremap <C-j> <C-\><C-N><C-w>ji
inoremap <C-k> <C-\><C-N><C-w>ki
inoremap <C-l> <C-\><C-N><C-w>li

"=============================================================================
"   Merge Conflicts                                         [MERGE_CONFLICTS]
"=============================================================================

" Resolving merge conflicts
    nnoremap dr :call DiffgetRe()<cr>
    nnoremap dn /<<<<<cr><C-d>N
    nnoremap dq :call ExitMergeResolutionIfDone()<cr>
