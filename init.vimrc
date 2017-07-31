set nocompatible        " non-compatible with basic vi
filetype off            " don't enable filetype detection during Vundle setup

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" " Local .vimrc settings
Plugin 'embear/vim-localvimrc'
    let g:localvimrc_ask=0
    let g:localvimrc_sandbox=0
    let g:localvimrc_name=['.yvimrc']

" " Fugitive
" " Wrapper for git.
"
" Usage:
"   :Gstatus
"       - to add-reset a file's changes
"       p to add-reset a patch
"   :Gcommit    =   commit changes to the current file
"   :Gblame     =   open interactive vertical split with git blame
"                   press enter on a line to edit the command where the line
"                       changed, or o to open in a split
"   :Gedit      =   in the historic buffer to return to the work tree version
"
"   :Gmove      =   automatic git mv and renames the buffer
"   :Gdelete    =   automatic git rm and deletes the buffer
"
"   :Ggrep      =   searches the work tree with git grep, skipping whatever's
"                       not tracked in the repo
"   :Glog       =   loads all previous revisions into the quickfix list,
"                       can iterate over them
"   :Gread      =   git checkout -- {active file} that operates on the buffer,
"                       not the file itself
"
"   :Gwrite     =   like git add when called from a working tree file, like
"                       git checkout when called from an index/blob from
"                       history
"
"   :Git        =   run an arbitrary command
"   :Git!       =   run an arbitrary command and open output in a temp file
Plugin 'tpope/vim-fugitive'

" " Easily modify the characters surrounding a particular word
"
" Usage:
"   cs"'        =   change surroundings (from) " to '
"   cs'<q>      =   change surroundings (from) ' to <q> ... </q>
"   cst"        =   change surroundings TO "
"   ds"         =   delete (from) surroundings "
"   ysiw]       =   YOOM surroundings (in word) ], producing [foo]
"   cs]{        =   change surroundings (from) ] to {fooOO, producing { foo }
"   cs]}        =   change surroundings (from) ] to }, producing {foo}
"   yss)        =   YOOM the entire line with )
"   ds{ds)      =   delete surroundings {ooOO, then delete surroundings )
"
"   In visual mode,
"       V                       =   line-wise visual select
"       S<p class"important">   =   SURROUND with this HTML tag
""  Produces:
"       <p class="important">
"         <em>Hello</em> world!
"       </p>
Plugin 'tpope/vim-surround'


" " Asynchronous syntax checker
Plugin 'neomake/neomake'
    " In normal map mode, press Ctrl-C to save buffer and run Syntastic check
    " backslash is necessary to escape pipe character
    " nnoremap <C-c> :w \| :call CloseErrorWindows() \| :Neomake \| :call Highlight() <cr>
    " nnoremap <C-c> :w \| :call CloseErrorWindows() \| :Neomake <cr>
    nnoremap <C-c> :call WriteAndLint() <cr>

    " In normal map mode, press Ctrl-Z to close Syntastic error window
    nnoremap <C-z> :call CloseErrorWindows() <cr>

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

Plugin 'scrooloose/nerdtree'
    " Open NerdTree automatically if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    " Open NerdTree if you do vim <dir>
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

    " Close NerdTree if it's the only window open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Open NerdTree with CTRL-N
    map <C-n> :NERDTreeToggle<cr>

    let NERDTreeQuitOnOpen = 1


Plugin 'tpope/vim-unimpaired'

" " All of your Plugins must be added before the following line
call vundle#end()           " required

filetype plugin indent on   " required, filetype detect, indenting per lang
" " To ignore plugin indent changes, instead use:
" "filetype plugin on

" " Brief help
" " :PluginList    - lists configured plugins
" " :PluginInstall  - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
