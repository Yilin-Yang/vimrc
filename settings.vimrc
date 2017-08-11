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
set nohidden                        " Disallow hidden buffers.
set visualbell                      " FOR THE LOVE OF GOD STOP BOOPING IN WSL
set showcmd                         " See leader key in corner

" Appearance
syntax on                           " Turn on syntax highlighting
set background=dark                 " Make text readable on dark background
set foldcolumn=1                    " Show a column with all folds

" Information Density
    set relativenumber              " Relative numbering!
    set number                      " Show line numbers
    set ruler                       " Show line lengths
    set cursorline                  " Mark the current line
    set cursorcolumn                " Mark the current column
        hi CursorColumn cterm=NONE ctermbg=235 ctermfg=white guibg=235 guifg=white
                                    " ^ very dark gray
                                    "           ^ creates a cool effect

" Color Reference
"   https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg