" Colorscheme
colorscheme default " For now, all this does is trigger the autocmd for changing
                    " Neomake's highlight colors

" Tab Heresy
set expandtab                       " Spaces for indentation
set shiftwidth=4                    " Indentation depth with << and >> commands
set tabstop=4                       " One tab counts for four spaces

" Behavior
set backspace=indent,eol,start      " Backspace over autoindents, line breaks,
                                    " position at start of insert mode
set timeoutlen=200                  " Decrease timeout for combined keymaps
set scrolloff=20
set nohidden                        " Disallow hidden buffers.
set visualbell                      " FOR THE LOVE OF GOD STOP BOOPING IN WSL
set showcmd                         " See leader key in corner
set lazyredraw                      " Only redraw after given command has completed
set completeopt=menuone,noinsert    " Show pop-up menu even when
                                    " there's only one option, don't insert
                                    " text without user input.


let g:cm_completeopt=&completeopt   " workaround to prevent overriding by
                                    " nvim-completion-manager

" Appearance
syntax on                           " Turn on syntax highlighting
set background=dark                 " Make text readable on dark background
set foldcolumn=1                    " Show a column with all folds
set listchars=tab:│·,extends:>,precedes:<,nbsp:+
set list
set nowrap                          " Don't wrap lines that are too long

" Information Density
    set relativenumber              " Relative numbering!
    set number                      " Show line numbers
    set ruler                       " Show line lengths
    set cursorline                  " Mark the current line
    set cursorcolumn                " Mark the current column
        hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=white guibg=NONE guifg=white
                                    " ^ very dark gray
                                    "           ^ creates a cool effect

" Color Reference
"   https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
