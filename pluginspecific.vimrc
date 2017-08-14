"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   Neomake                                                 [NEOMAKE]
"   NerdTree                                                [NERDTREE]
"   Tagbar                                                  [TAGBAR]
"   deoplete                                                [DEOPLETE]
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
nnoremap <silent> <Leader>b :TagbarToggle<CR>

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
