"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   System                                                  [SYSTEM]
"   Ordinary                                                [ORDINARY]
"   User Interface                                          [UI]
"   Split Navigation                                        [SPLITS]
"=============================================================================

"=============================================================================
"   System                                                  [SYSTEM]
"=============================================================================

" Enable paste-mode that doesn't autotab.
set pastetoggle=<F2>

" Set my preferred leader key.
let g:mapleader="\<Space>"

" Set my preferred local leader, primarily used with vimtex.
let g:maplocalleader="\\"

if has('nvim')
    " Enable use of Ctrl-Backspace to 'delete a word'.
    " NOTE: this only works because neovim handles keycodes differently; it
    "       will not work properly on standard vim.
    inoremap <C-h> <C-w>
    cnoremap <C-h> <C-w>
endif

"=============================================================================
"   Ordinary                                                [ORDINARY]
"=============================================================================

" Refresh the current buffer.
nnoremap <silent> <F5> :e<cr>

" Write the current buffer by double-tapping the leader key.
nnoremap <leader><leader> :w<cr>

" Exit interactive/visual mode by hitting j and k.
inoremap jk <esc>
vnoremap jk <esc>

" Close a split by hitting sk ('split-kill').
noremap <silent> sk <esc>:q<cr>

if has('nvim')
    " " nvim specific, not needed for vim.
    " Map j and k to exiting terminal mode.
    tnoremap jk <C-\><C-n>

    " Ditto with ESC.
    tnoremap <Esc> <C-\><C-n>

    " Control plus HJKL to move between windows in terminal mode.
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l
else
    " " vim specific, not needed for nvim.

    " Enable use of Alt key as modifier (sends Escape character).
    execute "set <M-d>=\ed"
    execute "set <M-a>=\ea"
endif

" Scroll laterally by large amounts.
nnoremap H 40h
nnoremap L 40l

" Tabs
    " Alt + A/D to move through tabs
    nnoremap <silent> <M-a> :tabp<cr>
    nnoremap <silent> <M-d> :tabn<cr>

    " Alt + J/K to move through tabs
    nnoremap <silent> <M-j> :tabp<cr>
    nnoremap <silent> <M-k> :tabn<cr>

    " Alt + E/Q to open/close tabs
    nnoremap <silent> <M-e> :tabnew<cr>:NERDTreeToggle<cr>
    nnoremap <silent> <M-q> :tabclose<cr>

    " Alt + N/C to open/close tabs
    nnoremap <silent> <M-n> :tabnew<cr>:NERDTreeToggle<cr>
    nnoremap <silent> <M-c> :tabclose<cr>

    " Alt + H to clear highlights and error windows
    nnoremap <silent> <M-h> :call CloseErrorWindows()<cr>:noh<cr>
        \ :echo "Cleared highlights."<cr>

    " Number row zero and +/- to open and close tabs
    nnoremap <silent> 0= :tabnew<cr>:NERDTreeToggle<cr>
    nnoremap <silent> 0- :tabclose<cr>

" Exit the rabbit hole
" " (If you dug too deep into a location list, etc.)
nnoremap <silent> <leader>^ :e#1<cr>

" Rewrap the current paragraph.
nnoremap <leader>w vipJgqq

" Sort the highlighted lines.
vnoremap <silent> <leader>s :sort<cr>

" Reformat text that lay within parentheses (function calls, headers...)
vnoremap <silent> <leader>f :call ReformatMultilineParentheses()<cr>

" Start a search command for a regex pattern *only* within the current window.
" " Taken from:
" "     https://www.reddit.com/r/vim/comments/8mrwu3/search_in_part_of_file/dzpwjtn/
nnoremap <expr> z/ '/\%(\%>'.(line('w0')-1).'l\%<'.(line('w$')+1).'l\)\&'

"=============================================================================
"   User Interface                                          [UI]
"=============================================================================
" Open Location List
nnoremap <silent> <leader>l :call CloseErrorWindows()<cr>:lopen<cr>

" Open QuickFix List
nnoremap <silent> <leader>q :call CloseErrorWindows()<cr>:copen<cr>

"=============================================================================
"   Split Navigation                                        [SPLITS]
"=============================================================================

" Ctrl + hjkl to cycle through windows!
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
