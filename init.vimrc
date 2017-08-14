set nocompatible        " non-compatible with basic vi
filetype off            " don't enable filetype detection during Vundle setup

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" " Let Vundle manage Vundle. Required.
Plugin 'VundleVim/Vundle.vim'

" " Local .vimrc settings.
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


" " Asynchronous syntax checker.
Plugin 'neomake/neomake'

" " Open a vertical split for hopping between files.
Plugin 'scrooloose/nerdtree'

" " Some nice convenience keymappings using the square brackets.
"
" See documentation here: ~/.vim/bundle/vim-unimpaired/doc/unpaired.txt
Plugin 'tpope/vim-unimpaired'

" " Create a bar that shows you ctags for the current file.
Plugin 'majutsushi/tagbar'

" " Asynchronous autocompletion that's less bloated than YouCompleteMe.
" Requires neovim.
if has('nvim')
    Plugin 'Shougo/deoplete.nvim'

    " " Use included files and path for candidate completion!
    Plugin 'Shougo/neoinclude.vim'
endif

" " All of your Plugins must be added before the following line.
call vundle#end()           " required.

filetype plugin indent on   " required, filetype detect, indenting per lang

" Basic Vundle Commands:
" " :PluginList         - lists configured plugins
" " :PluginInstall      - installs plugins; append `!` to update or just :PluginUpdate
" " :PluginSearch foo   - searches for foo; append `!` to refresh local cache
" " :PluginClean        - confirms removal of unused plugins; append `!` to auto-approve removal.
" "
" " See :h vundle for more details or the wiki for an FAQ.
" " Put your non-Plugin stuff after this point.
