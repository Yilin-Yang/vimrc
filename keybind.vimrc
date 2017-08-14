"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   System                                                  [SYSTEM]
"   Ordinary                                                [ORDINARY]
"   Functions                                               [FUNCTIONS]
"   Split Navigation                                        [SPLITS]
"   Merge Conflicts                                         [MERGE_CONFLICTS]
"   Plugin Specific - Includes buffer events as well        [PLUGIN_SPECIFIC]
"=============================================================================

"=============================================================================
"   System                                                  [SYSTEM]
"=============================================================================

" Enable paste-mode that doesn't autotab
set pastetoggle=<F2>

" Set my preferred leader key
let mapleader=","

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

"=============================================================================
"   Plugin Specific                                         [PLUGIN_SPECIFIC]
"=============================================================================

"-----------------------------------------------------------------------------
"   Neomake
"-----------------------------------------------------------------------------
" In normal map mode, press Ctrl-C to save buffer and run Syntastic check
" backslash is necessary to escape pipe character
" nnoremap <silent> <C-c> :w \| :call CloseErrorWindows() \| :Neomake \| :call Highlight() <cr>
" nnoremap <silent> <C-c> :w \| :call CloseErrorWindows() \| :Neomake <cr>
nnoremap <silent> <C-c> :call WriteAndLint() <cr>

" In normal map mode, press Ctrl-Z to close Syntastic error window
nnoremap <silent> <C-z> :call CloseErrorWindows() <cr>

augroup neomake_scheme
    au!
    autocmd ColorScheme *
        \ hi link NeomakeError SpellBad |
        \ hi link NeomakeWarning Todo
augroup END

let g:neomake_open_list = 2 " Preserve cursor location on loc-list open
let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeError'}
let g:neomake_warning_sign = {
     \   'text': '⚠',
     \   'texthl': 'NeomakeWarning',
     \ }
let g:neomake_message_sign = {
      \   'text': '➤',
      \   'texthl': 'NeomakeMessageSign',
      \ }
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

let g:neomake_cpp_gcc_maker = {
    \ 'args': [
        \ '-fsyntax-only',
        \ '-Wall',
        \ '-Werror',
        \ '-pedantic',
        \ '-O1',
        \ '--std=c++11',
        \ '-I.',
        \ '-I..'
    \ ],
    \ 'exe': 'g++'
\ }
let g:neomake_cpp_enable_makers = ['gcc']

"-----------------------------------------------------------------------------
"   NerdTree
"-----------------------------------------------------------------------------
" Open NerdTree automatically if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NerdTree if you do vim <dir>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close NerdTree if it's the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NerdTree with CTRL-N
noremap <silent> <C-n> :NERDTreeToggle<cr>

let NERDTreeQuitOnOpen = 1

"-----------------------------------------------------------------------------
"   Tagbar
"-----------------------------------------------------------------------------
" Open an informational bar showing ctags for the current file.
nnoremap <silent> <Leader>b :TagbarToggle<CR>
