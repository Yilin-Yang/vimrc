"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   localvimrc                                              [LOCALVIMRC]
"   Fugitive                                                [FUGITIVE]
"   vim-surround                                            [SURROUND]
"   Neomake                                                 [NEOMAKE]
"   vimtex                                                  [VIMTEX]
"   vim-unimpaired                                          [UNIMPAIRED]
"   Tagbar                                                  [TAGBAR]
"   nvim-completion-manager                                 [NCM]
"   vim-easytags                                            [EASYTAGS]
"   lldb                                                    [LLDB]
"   ConqueGDB                                               [CONQUEGDB]
"   vim-snippets                                            [SNIPPETS]
"   UltiSnips                                               [ULTISNIPS]
"   LanguageClient-neovim                                   [LSP]
"   BufExplorer                                             [BUFFER]
"   vim-vebugger                                            [VEBUGGER]
"   vimproc                                                 [VIMPROC]
"   vim-obsession                                           [OBSESSION]
"   vim-repeat                                              [REPEAT]
"   vim-easymotion                                          [EASYMOTION]
"   vim-commentary                                          [COMMENTARY]
"   tabular                                                 [TABULAR]
"   vim-easy-align                                          [EASYALIGN]
"   vim-lexical                                             [LEXICAL]
"   ReplaceWithRegister                                     [REPLACEREGISTER]
"   vim-rsi                                                 [RSI]
"   vim-tmux-focus-events                                   [FOCUSEVENTS]
"   fuzzy-find                                              [FZF]
"   fuzzy-find vim plugin                                   [FZFVIM]
"   vim-airline                                             [AIRLINE]
"   vim-pencil                                              [PENCIL]
"   vim-wordy                                               [WORDY]
"   vim-textobj-user                                        [TEXTOBJ_USER]
"   vim-textobj-sentence                                    [TEXTOBJ_SENTENCE]
"   vimwiki                                                 [VIMWIKI]
"   diffconflicts                                           [DIFFCONFLICTS]
"=============================================================================

set nocompatible        " non-compatible with basic vi

" Basic Plug Commands:
" PlugInstall [name ...] [#threads]     Install plugins
" PlugUpdate [name ...] [#threads]      Install or update plugins
" PlugClean[!]                          Remove unused directories (bang
"                                           version will clean without prompt)
" PlugUpgrade                           Upgrade vim-plug itself
" PlugStatus                            Check the status of plugins
" PlugDiff                              Examine changes from the previous
"                                           update and the pending changes
" PlugSnapshot[!] [output path]         Generate script for restoring the
"                                           current snapshot of the plugins
" "
"#############################################################################
"#############################################################################
"                               BEGIN PLUGINS
"#############################################################################
"#############################################################################

call plug#begin('~/.vim/bundle')

"=============================================================================
"   localvimrc                                              [LOCALVIMRC]
"=============================================================================
"-----------------------------------------------------------------------------
" Local .vimrc settings.
Plug 'embear/vim-localvimrc'

"=============================================================================
"   Fugitive                                                [FUGITIVE]
"=============================================================================
"-----------------------------------------------------------------------------
" Wrapper for git.
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
"=============================================================================
Plug 'tpope/vim-fugitive'

"=============================================================================
"   vim-surround                                            [SURROUND]
"=============================================================================
"-----------------------------------------------------------------------------
" Easily edit the characters surrounding a given word.
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
Plug 'tpope/vim-surround'


"=============================================================================
"   Neomake                                                 [NEOMAKE]
"=============================================================================
"-----------------------------------------------------------------------------
" " Asynchronous syntax checker.
Plug 'neomake/neomake'

"=============================================================================
"   vimtex                                                  [VIMTEX]
"=============================================================================
" " LaTeX plugin for vim. Support for document compilation, PDF viewers,
" navigation, etc.
Plug 'lervag/vimtex'

"=============================================================================
"   NerdTree                                                [NERDTREE]
"=============================================================================
"-----------------------------------------------------------------------------
" " Open a vertical split for hopping between files.
Plug 'scrooloose/nerdtree'

"=============================================================================
"   vim-unimpaired                                          [UNIMPAIRED]
"=============================================================================
"-----------------------------------------------------------------------------
" " Some nice convenience keymappings using the square brackets.
"
" See documentation here: ~/.vim/bundle/vim-unimpaired/doc/unpaired.txt
Plug 'tpope/vim-unimpaired'

"=============================================================================
"   Tagbar                                                  [TAGBAR]
"=============================================================================
"-----------------------------------------------------------------------------
" " Create a bar that shows you ctags for the current file.
Plug 'majutsushi/tagbar'

"=============================================================================
"   nvim-completion-manager                                 [NCM]
"=============================================================================
"-----------------------------------------------------------------------------
" " Asynchronous autocompletion that's less bloated than YouCompleteMe and
" better written/maintained than deoplete. Requires neovim.
if has('nvim')
    Plug 'roxma/nvim-completion-manager'
endif

" " Dependency for vim-easytags.
Plug 'xolox/vim-misc'

"=============================================================================
"   vim-easytags                                            [EASYTAGS]
"=============================================================================
"-----------------------------------------------------------------------------
" " Automatic tag generation for whatever file I'm using!
" This variable has to be set before loading the plugin.
let g:easytags_include_members = 1  " Generate tags for struct/class *members*.
Plug 'xolox/vim-easytags'

"=============================================================================
"   lldb.nvim                                                    [LLDB]
"=============================================================================
"-----------------------------------------------------------------------------
" " IDE-like debugger integration for vim.
if has('nvim')
    Plug 'dbgx/lldb.nvim'
endif

"=============================================================================
"   ConqueGDB                                               [CONQUEGDB]
"=============================================================================
Plug 'vim-scripts/Conque-GDB', { 'on': 'StartConqueGDB' }

"=============================================================================
"   vim-snippets                                            [SNIPPETS]
"=============================================================================
"-----------------------------------------------------------------------------
" " Actual implementation of snippets. Requires an engine, like UltiSnips.
Plug 'honza/vim-snippets'

"=============================================================================
"   UltiSnips                                               [ULTISNIPS]
"=============================================================================
"-----------------------------------------------------------------------------
" " Snippets engine that uses Python and neocomplete.
Plug 'SirVer/ultisnips'

"=============================================================================
"   LanguageClient-neovim                                   [LSP]
"=============================================================================
"-----------------------------------------------------------------------------
" " Enables neovim support for Language Server Protocol.
" Requires neovim.
if has('nvim')
    Plug 'autozimu/LanguageClient-neovim'
endif

"=============================================================================
"   BufExplorer                                             [BUFFER]
"=============================================================================
" " Navigate open buffers.
Plug 'jlanzarotta/bufexplorer'

"=============================================================================
"   vim-vebugger                                            [VEBUGGER]
"=============================================================================
" " More modular debugger frontend for Vim.
" Requires Shougo/vimproc for async support. Grr, shake fist.
Plug 'idanarye/vim-vebugger'

"=============================================================================
"   vimproc                                                 [VIMPROC]
"=============================================================================
" " Asynchronous job support. Required by vim-vebugger.
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

"=============================================================================
"   vim-obsession                                           [OBSESSION]
"=============================================================================
" " Autosave vim sessions as I go.
Plug 'tpope/vim-obsession'

"=============================================================================
"   vim-repeat                                              [REPEAT]
"=============================================================================
" " Repeat vim-surround commands using the period command.
Plug 'tpope/vim-repeat'

"=============================================================================
"   vim-easymotion                                          [EASYMOTION]
"=============================================================================
" " Text navigation! Navigate all about!
Plug 'easymotion/vim-easymotion'

"=============================================================================
"   vim-commentary                                          [COMMENTARY]
"=============================================================================
" " Comment stuff out!
Plug 'tpope/vim-commentary'

"=============================================================================
"   tabular                                                 [TABULAR]
"=============================================================================
" " Space-alignment of things!
Plug 'godlygeek/tabular'

"=============================================================================
"   vim-easy-align                                          [EASYALIGN]
"=============================================================================
" " Align things more easily! A bit more configurable than tabular.
Plug 'junegunn/vim-easy-align'

"=============================================================================
"   vim-lexical                                             [LEXICAL]
"=============================================================================
" " Spellchecker and such!
Plug 'reedes/vim-lexical'

"=============================================================================
"   ReplaceWithRegister                                     [REPLACEREGISTER]
"=============================================================================
" " Use [count][''x]gr to overwrite the given text with the contents of
" " register 'x', without clobbering the unnamed register.
" NOTE: gr is the default keybinding, which I've replaced with <Leader>r.
Plug 'vim-scripts/ReplaceWithRegister'

"=============================================================================
"   vim-rsi                                                 [RSI]
"=============================================================================
" " Use Readline mappings inside of vim, including vim's command line.
Plug 'https://github.com/tpope/vim-rsi'

"=============================================================================
"   vim-tmux-focus-events                                   [FOCUSEVENTS]
"=============================================================================
" " Make the 'FocusGained' event, etc. work properly in tmux and the terminal.
Plug 'tmux-plugins/vim-tmux-focus-events'

"=============================================================================
"   fuzzy-find                                              [FZF]
"=============================================================================
" " Search for things very speedily.
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf, run the install script.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

"=============================================================================
"   fuzzy-find vim plugin                                   [FZFVIM]
"=============================================================================
" " A 'default' fuzzyfind vim plugin, written by fuzzyfind's maintainer.
Plug 'junegunn/fzf.vim'

"=============================================================================
"   vim-airline                                             [AIRLINE]
"=============================================================================
" " Prettier, more informative statusline.
Plug 'vim-airline/vim-airline'

" " Different themes.
Plug 'vim-airline/vim-airline-themes'

"=============================================================================
"   vim-pencil                                              [PENCIL]
"=============================================================================
" " Better support for editing prose documents (e.g. markdown, TeX)
Plug 'reedes/vim-pencil'

"=============================================================================
"   vim-wordy                                               [WORDY]
"=============================================================================
" " Check for word usage problems in prose writing.
Plug 'reedes/vim-wordy'

"=============================================================================
"   vim-textobj-user                                     [TEXTOBJ_USER]
"=============================================================================
" " Dependency for vim-textobj-sentence.
Plug 'kana/vim-textobj-user'

"=============================================================================
"   vim-textobj-sentence                                    [TEXTOBJ_SENTENCE]
"=============================================================================
" " Improve vim's built-in textobject detection (handle abbreviations, etc.)
Plug 'reedes/vim-textobj-sentence'

"=============================================================================
"   vimwiki                                                 [VIMWIKI]
"=============================================================================
" " Personal wiki and task organization for vim!
Plug 'vimwiki/vimwiki'

"=============================================================================
"   diffconflicts                                           [DIFFCONFLICTS]
"=============================================================================
" " Easy, intuitive two-way git diffs!
Plug 'whiteinge/diffconflicts'

"#############################################################################
" " All of your Plugins must be added before the following line.
call plug#end()           " required.

"#############################################################################
"#############################################################################
"                               END PLUGINS
"#############################################################################
"#############################################################################

filetype plugin indent on   " required, filetype detect, indenting per lang
