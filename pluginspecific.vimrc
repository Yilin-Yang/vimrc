"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   Neomake                                                 [NEOMAKE]
"   NerdTree                                                [NERDTREE]
"   Tagbar                                                  [TAGBAR]
"   deoplete                                                [DEOPLETE]
"   vim-easytags                                            [EASYTAGS]
"=============================================================================

"=============================================================================
"   Neomake                                                 [NEOMAKE]
"=============================================================================
" In normal map mode, press Ctrl-C to save buffer and run Syntastic check
" backslash is necessary to escape pipe character
" nnoremap <silent> <C-c> :w \| :call CloseErrorWindows() \| :Neomake \| :call Highlight() <cr>
" nnoremap <silent> <C-c> :w \| :call CloseErrorWindows() \| :Neomake <cr>
nnoremap <silent> <C-c> :call WriteAndLint() <cr>

" In normal map mode, press Ctrl-Z to close Syntastic error window
nnoremap <silent> <C-z> :call CloseErrorWindows() <cr>

" For whatever reason, the ColorScheme event doesn't fire anymore?.
augroup neomake_scheme
    au!
    autocmd BufWinEnter *
        \ hi link NeomakeError Error |
        \ hi link NeomakeWarning Todo |
        \ hi link NeomakeInfo Statement |
        \ hi link NeomakeMessage Todo |
augroup END

let g:neomake_open_list = 2 " Preserve cursor location on loc-list open
let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeError'}
let g:neomake_warning_sign = {
     \   'text': '⚠',
     \   'texthl': 'NeomakeWarning',
     \ }
let g:neomake_message_sign = {
      \   'text': '➤',
      \   'texthl': 'NeomakeMessage',
      \ }
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfo'}

let g:neomake_cpp_gcc_maker = {
    \ 'exe': 'g++',
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
\ }
let g:neomake_cpp_enabled_makers = ['gcc']

"=============================================================================
"   NerdTree                                                [NERDTREE]
"=============================================================================
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

"=============================================================================
"   Tagbar                                                  [TAGBAR]
"=============================================================================
" Open an informational bar showing ctags for the current file.
" Will open Tagbar, jump to it, and close after choosing a tag.
nnoremap <silent> <Leader>g :TagbarOpenAutoClose<cr>
nnoremap <silent> <Leader>b :TagbarToggle<cr>

"=============================================================================
"   deoplete                                                [DEOPLETE]
"=============================================================================
if has('nvim')
    " Run at startup.
    let g:deoplete#enable_at_startup = 1

    " Make sure that autocompletion will actually trigger.
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif

    " Close scratch window upon leaving a buffer.
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    " omnifuncs
    augroup omnifuncs
      autocmd!
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup end

    " Insert mode tab-completion without breaking real presses of the tab key.
    inoremap <expr><tab> pumvisible() ? DeopleteTab() : "\<tab>"
endif

"=============================================================================
"   vim-easytags                                            [EASYTAGS]
"=============================================================================

" General Settings
    let g:easytags_file = '~/.tags'     " Store tags in the home directory.
    let g:easytags_auto_highlight = 0   " Disable tag highlighting.

" Performance Settings
    let g:easytags_async = 1            " Generate tags asynchronously.
    "let g:easytags_python_enabled = 1   " Use faster Python syntax highlighter.

"   With this setup, it's actually a bad idea to turn this option on.
"       I ran :UpdateTags inside of /usr, and the tags file it generated was
"   over a gibibyte (GiB) in size.
"       It's probably okay to turn this on in a local .vimrc, especially
"   with asynchronous execution, but if you turn it on globally, you run
"   the risk of making your global tags file unusably large.
"
" let g:easytags_autorecurse = 1      " Generate tags for all subdirs as well.

" Recursively generate tags for the current file, and everything in
"   subdirectories below.
nnoremap <silent> <Leader>tu :UpdateGlobalTags<cr>

" Update Frequency

    "let g:easytags_on_cursorhold = 1    " Run :UpdateTags whenever idle.

    " Try to trigger this all the time. Wasteful multithreading HO!
    "let g:easytags_always_enabled = 1   " HA HA HA HA HAAAAAAAA
    let g:easytags_events = [
        \ 'BufWritePost',
        \ 'BufEnter',
        \ 'BufLeave'
    \ ]
