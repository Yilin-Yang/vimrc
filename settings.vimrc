scriptencoding utf-8
"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   Tab Heresy                                              [BYTHEEMPEROR]
"   Editor Behavior                                         [BEHAVIOR]
"   Spellchecking                                           [SPELLCHECK]
"   Folding                                                 [FOLDING]
"   Appearance                                              [APPEARANCE]
"   Highlighting                                            [HIGHLIGHTING]
"   User Interface                                          [USER INTERFACE]
"   System Configuration                                    [CONFIG]
"=============================================================================

"=============================================================================
"   Tab Heresy                                              [BYTHEEMPEROR]
"=============================================================================
set expandtab                       " Spaces for indentation.
set shiftwidth=2                    " Indentation depth with << and >> commands.
set softtabstop=-1                  " The number of columns to insert when pressing
                                    " <Tab>. Helpful when *forced* to indent with mixed
                                    " tabs and spaces, like *profligate scum*.
                                    " (Negative value => use value of `shiftwidth`.)
set tabstop=8                       " By default, most editors come configured with a
                                    " default tab-width of 8 columns, and
                                    " having that width set differently can
                                    " make files written in those editors look weird.

"=============================================================================
"   Editor Behavior                                         [BEHAVIOR]
"=============================================================================
set backspace=indent,eol,start      " Backspace over autoindents, line breaks,
                                    " position at start of insert mode.
set timeoutlen=200                  " Decrease timeout for combined keymaps.
set updatetime=1000                 " More frequent swapbacks, CursorHold procs
set scrolloff=20                    " The minimum number of lines that vim
                                    " will keep between the cursor and the
                                    " top/bottom of the screen when scrolling.
set hidden                          " Allow hidden buffers.
set visualbell                      " FOR THE LOVE OF GOD STOP BOOPING IN WSL
set showcmd                         " See leader key in corner.
set lazyredraw                      " Only redraw after given command has completed
set shortmess=aoOtTF                " Abbreviate commandline text.
set completeopt=menuone,noinsert    " Show pop-up menu even when
                                    " there's only one option, don't insert
                                    " text without user input.
if has('nvim')
    set inccommand=nosplit          " Show command effects incrementally.
endif


let g:cm_completeopt=&completeopt   " workaround to prevent overriding by
                                    " nvim-completion-manager

"=============================================================================
"   Spellchecking                                           [SPELLCHECK]
"=============================================================================
" Further information on vim spellfile configuration can be found here:
"   https://vi.stackexchange.com/a/5521
"   https://stackoverflow.com/a/40832571
"=============================================================================
set spelllang=en_us
set spellfile=$HOME/vimrc/spellfile/en.utf-8.add
                                    " Use the version-controlled spellfiles
                                    " in my vimrc repository.

"=============================================================================
"   Folding                                                 [FOLDING]
"=============================================================================
let g:foldmethod='syntax'           " Make it easier to collapse/expand parts of
                                    " a large text file.
execute 'set foldmethod=' . g:foldmethod
set foldlevel=20                    " All folds default to being open.


"=============================================================================
"   Appearance                                              [APPEARANCE]
"=============================================================================
colorscheme yilin

syntax on                           " Turn on syntax highlighting.
set background=dark                 " Make text readable on dark background.
set breakindent                     " Visually indent when softwrapping.
set foldcolumn=1                    " Show a column with all folds.
set nowrap                          " Don't visually wrap lines that are too long.
set list                            " Explicitly render `listchars`.
set listchars=tab:│·,extends:>,precedes:<,nbsp:+
set fillchars+=vert:│

"=============================================================================
"   User Interface                                          [USER INTERFACE]
"=============================================================================
set relativenumber              " Relative numbering!
set number                      " Show absolute line numbers.
set ruler                       " Show line lengths in the statusline.
set nocursorline                " Don't underline the current line.
set cursorcolumn                " Mark the current column.

"=============================================================================
"   System Configuration                                    [CONFIG]
"=============================================================================
" I literally never use swapfiles, and I habitually save my files every
" fifteen seconds or so.
set noswapfile

" Shorten startup time by explicitly specifying python path.
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo
