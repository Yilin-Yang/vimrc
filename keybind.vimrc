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
    nnoremap <silent> <M-a> :tabp<cr>
    nnoremap <silent> <M-d> :tabn<cr>

    " Alt + J/K to move through tabs
    nnoremap <silent> <M-j> :tabp<cr>
    nnoremap <silent> <M-k> :tabn<cr>

    " Alt + N/C to open/close tabs
    nnoremap <silent> <M-n> :tabnew<cr>:NERDTreeToggle<cr>
    nnoremap <silent> <M-c> :tabclose<cr>

    " Alt + H to clear highlights and error windows
    nnoremap <silent> <M-h> :call CloseErrorWindows()<cr>:noh<cr>:echo "Cleared highlights."<cr>

    " Number row zero and +/- to open and close tabs
    nnoremap <silent> 0= :tabnew<cr>:NERDTreeToggle<cr>
    nnoremap <silent> 0- :tabclose<cr>

"=============================================================================
"   System                                                  [SYSTEM]
"=============================================================================

" Enable paste-mode that doesn't autotab
set pastetoggle=<F2>

" Set my preferred leader key
let mapleader=","

"=============================================================================
"   Functions                                               [FUNCTIONS]
"=============================================================================

" Function Key Toggles
"   Toggle Fold
    nnoremap <silent> <F5> :call FoldFunctionBodies()<cr>

"   Wrap/Unwrap Lines
    nnoremap <silent> <F3> :call WrapAll()<cr>
    nnoremap <silent> <F4> :call UnwrapAll()<cr>

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
    nnoremap <silent> dr :call DiffgetRe()<cr>
    nnoremap <silent> dn /<<<<<cr><C-d>N
    nnoremap <silent> dq :call ExitMergeResolutionIfDone()<cr>
