"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   vim-maktaba                                             [MAKTABA]
"   vim-glaive                                              [GLAIVE]
"   localvimrc                                              [LOCALVIMRC]
"   Fugitive                                                [FUGITIVE]
"   vim-surround                                            [SURROUND]
"   Asynchronous Lint Engine                                [ALE]
"   vimtex                                                  [VIMTEX]
"   vim-unimpaired                                          [UNIMPAIRED]
"   lldb                                                    [LLDB]
"   vim-snippets                                            [SNIPPETS]
"   UltiSnips                                               [ULTISNIPS]
"   coc.nvim                                                [COC]
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
"   lightline.vim                                           [LIGHTLINE]
"   vim-pencil                                              [PENCIL]
"   vim-wordy                                               [WORDY]
"   vim-textobj-user                                        [TEXTOBJ_USER]
"   vim-textobj-sentence                                    [TEXTOBJ_SENTENCE]
"   vimwiki                                                 [VIMWIKI]
"   diffconflicts                                           [DIFFCONFLICTS]
"   winresizer                                              [WINRESIZER]
"   vim-abolish                                             [ABOLISH]
"   vim-signify                                             [SIGNIFY]
"   vim-eunuch                                              [EUNUCH]
"   quick-scope                                             [QUICKSCOPE]
"   gv.vim                                                  [GVVIM]
"   vim-indent-object                                       [INDENTOBJECT]
"   vader.vim                                               [VADER]
"   vim-markbar                                             [MARKBAR]
"   vim-peekaboo                                            [PEEKABOO]
"   vim-illuminate                                          [ILLUMINATE]
"   traces.vim                                              [TRACES]
"   editorconfig-vim                                        [EDITORCFG]
"   typescript-vim                                          [TS-VIM]
"   vim-signature                                           [SIGNATURE]
"   dapper.nvim                                             [DAPPER]
"   vim-mundo                                               [MUNDO]
"   vim-syncopate                                           [SYNCOPATE]
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
"   vim-maktaba                                             [MAKTABA]
"=============================================================================
"-----------------------------------------------------------------------------
" " Consistent plugin design, by Google.
Plug 'Google/vim-maktaba'

"=============================================================================
"   vim-glaive                                              [GLAIVE]
"=============================================================================
"-----------------------------------------------------------------------------
" " Consistent plugin configuration, by Google.
Plug 'Google/vim-glaive'

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
"   Asynchronous Lint Engine                                [ALE]
"=============================================================================
"-----------------------------------------------------------------------------
" " Asynchronous linting as you type.
Plug 'w0rp/ale'

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
"   lldb.nvim                                                    [LLDB]
"=============================================================================
"-----------------------------------------------------------------------------
" " IDE-like debugger integration for vim.
if has('nvim')
    Plug 'dbgx/lldb.nvim'
endif

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
" Plug 'SirVer/ultisnips'

"=============================================================================
"   coc.nvim                                                [COC]
"=============================================================================
"-----------------------------------------------------------------------------
" " IntelliSense in neovim!.
Plug 'neoclide/coc.nvim', {
    \ 'tag': '*',
    \ 'do': 'yarn install',
\ }

Plug 'neoclide/coc-sources'
Plug 'neoclide/coc-neco'
    Plug 'Shougo/neco-vim'

function! InstallCoCExtensions() abort
  CocInstall coc-tsserver coc-tslint coc-yaml coc-java coc-python coc-json coc-html coc-css

  " coc-sources extensions
  CocInstall coc-ultisnips
endfunction

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
"   lightline.vim                                           [LIGHTLINE]
"=============================================================================
" " Prettier, more informative statusline.
" Also significantly faster than vim-airline.
Plug 'itchyny/lightline.vim'

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

"=============================================================================
"   winresizer                                              [WINRESIZER]
"=============================================================================
" " More easily resize splits.
Plug 'simeji/winresizer'

"=============================================================================
"   vim-abolish                                             [ABOLISH]
"=============================================================================
" " Capitalization-/Suffix-/Pluralization-/etc. aware search-and-replace.
Plug 'tpope/vim-abolish'

"=============================================================================
"   vim-signify                                             [SIGNIFY]
"=============================================================================
" " Display version-control diffs (e.g. git) in the sign column.
Plug 'mhinz/vim-signify'

"=============================================================================
"   vim-eunuch                                              [EUNUCH]
"=============================================================================
" Commands that make working on Unix systems more pleasant.
"
" USAGE:
"   :Delete         Delete a buffer and the file on disk simultaneously.
"   :Unlink         Like :Delete, but keeps the now empty buffer.
"   :Move           Rename a buffer and the file on disk simultaneously.
"   :Rename         Like :Move, but relative to the current file's
"                       containing directory.
"   :Chmod          Change the permissions of the current file.
"   :Mkdir          Create a directory, defaulting to the parent of the
"                       current file.
"
"   :Cfind          Run find and load the results into the quickfix list.
"   :Clocate        Run locate and load the results into the quickfix list.
"
"   :Lfind          Like above, but use the location list.
"   :Llocate        Like above, but use the location list.
"   :Wall           Write every open window. Handy for kicking off tools
"                       like guard.
"   :SudoWrite      Write a privileged file with sudo.
"   :SudoEdit       Edit a privileged file with sudo.
"=============================================================================
Plug 'tpope/vim-eunuch'

"=============================================================================
"   quick-scope                                             [QUICKSCOPE]
"=============================================================================
" " Highlight targets for character motions.
Plug 'unblevable/quick-scope'

"=============================================================================
"   gv.vim                                                  [GVVIM]
"=============================================================================
" " Detailed commit history browser.
Plug 'junegunn/gv.vim'

"=============================================================================
"   vim-indent-object                                       [INDENTOBJECT]
"=============================================================================
" " Define a new text object (`i`) representing an indentation level.
" USAGE:
"   <count>ai       line Above + Indentation block
"   <count>ii       Inside Indentation block
"   <count>aI       line Above + Indentation block + line below
"=============================================================================
Plug 'michaeljsmith/vim-indent-object'

"=============================================================================
"   vader.vim                                               [VADER]
"=============================================================================
" " Test case framework for vim plugins.
Plug 'junegunn/vader.vim'

"=============================================================================
"   vim-markbar                                             [MARKBAR]
"=============================================================================
" " See all of your marks in a sidebar.
Plug 'Yilin-Yang/vim-markbar'

"=============================================================================
"   vim-peekaboo                                            [PEEKABOO]
"=============================================================================
" " See the contents of your registers in the sidebar when appropriate.
" Plug 'junegunn/vim-peekaboo'

"=============================================================================
"   vim-illuminate                                          [ILLUMINATE]
"=============================================================================
" " Highlight other occurrences of the word under the cursor.
Plug 'RRethy/vim-illuminate'

"=============================================================================
"   traces.vim                                              [TRACES]
"=============================================================================
" " inccommand, but for ordinary vim.
if !has('nvim')
    Plug 'markonm/traces.vim'
endif

"=============================================================================
"   editorconfig-vim                                        [EDITORCFG]
"=============================================================================
" " Load editorconfig settings in git repositories.
Plug 'editorconfig/editorconfig-vim'

"=============================================================================
"   typescript-vim                                          [TS-VIM]
"=============================================================================
" " Syntax highlighting, filetype support for TypeScript.
Plug 'leafgarland/typescript-vim'

"=============================================================================
"   vim-signature                                           [SIGNATURE]
"=============================================================================
" " Display marks in the sign column.
Plug 'kshenoy/vim-signature'

"=============================================================================
"   dapper.nvim                                             [DAPPER]
"=============================================================================
" " Debug adapter protocol implementation for neovim.
Plug 'Yilin-Yang/dapper.nvim'

  Plug 'Yilin-Yang/VSCrib.vim'

  Plug 'Yilin-Yang/TypeVim'

"=============================================================================
"   vim-mundo                                               [MUNDO]
"=============================================================================
" " Visualize the vim undo tree.
Plug 'simnalamburt/vim-mundo'

"=============================================================================
"   vim-syncopate                                           [SYNCOPATE]
"=============================================================================
" " Syntax-highlighted copy paste.
Plug 'google/vim-syncopate'

"#############################################################################
" " All of your Plugins must be added before the following line.
call plug#end()           " required.

call glaive#Install()     " allow glaive configuration past this point

"#############################################################################
"#############################################################################
"                               END PLUGINS
"#############################################################################
"#############################################################################

filetype plugin indent on   " required, filetype detect, indenting per lang
