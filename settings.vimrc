" Colorscheme
colorscheme default " For now, all this does is trigger the autocmd for changing
                    " Neomake's highlight colors

" Tab Heresy
set expandtab                       " Spaces for indentation.
set shiftwidth=4                    " Indentation depth with << and >> commands.
set softtabstop=-1                  " The number of columns to insert when pressing
                                    " <Tab>. Helpful when *forced* to indent with mixed
                                    " tabs and spaces, like *profligate scum*.
                                    " (Negative value => use value of `shiftwidth`.)
set tabstop=8                       " By default, most editors come configured with a
                                    " default tab-width of 8 columns, and
                                    " having that width set differently can
                                    " make files written in those editors look weird.

" Behavior
set backspace=indent,eol,start      " Backspace over autoindents, line breaks,
                                    " position at start of insert mode.
set timeoutlen=200                  " Decrease timeout for combined keymaps.
set scrolloff=20                    " The minimum number of lines that vim
                                    " will keep between the cursor and the
                                    " top/bottom of the screen when scrolling.
set hidden                          " Allow hidden buffers.
set visualbell                      " FOR THE LOVE OF GOD STOP BOOPING IN WSL
set showcmd                         " See leader key in corner.
set lazyredraw                      " Only redraw after given command has completed
set completeopt=menuone,noinsert    " Show pop-up menu even when
                                    " there's only one option, don't insert
                                    " text without user input.


let g:cm_completeopt=&completeopt   " workaround to prevent overriding by
                                    " nvim-completion-manager

" Spellchecking
" Further information on vim spellfile configuration can be found here:
"   https://vi.stackexchange.com/a/5521
"   https://stackoverflow.com/a/40832571
set spelllang=en_us
set spellfile=$HOME/vimrc/spellfile/en.utf-8.add
                                    " Use the version-controlled spellfiles
                                    " in my vimrc repository.

" Folding
let g:foldmethod="syntax"           " Make it easier to collapse/expand parts of
                                    " a large text file.
execute "set foldmethod=" . g:foldmethod
set foldlevel=20                    " All folds default to being open.



" Appearance
syntax on                           " Turn on syntax highlighting.
set background=dark                 " Make text readable on dark background.
set foldcolumn=1                    " Show a column with all folds.
set nowrap                          " Don't visually wrap lines that are too long.
set list                            " Explicitly render `listchars`.
set listchars=tab:│·,extends:>,precedes:<,nbsp:+
set fillchars+=vert:│

" Highlighting
" Further information on highlight groups and highlight color values
" can be found through:
"   :help highlight-groups
"   :help gui-colors
"   https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg

    " Less obtrusive `listchars`.
    hi SpecialKey ctermbg=NONE ctermfg=darkgray guibg=bg guifg=darkgray

    hi clear Whitespace
    hi link Whitespace SpecialKey
    hi clear NonText
    hi link NonText SpecialKey

    " Less obtrusive spellchecker markings.
    hi SpellBad cterm=underline ctermfg=DarkRed ctermbg=NONE

    " Less obtrusive vertical splits.
    hi clear VertSplit
    hi link VertSplit Delimiter

    " Disable ugly gray background in visual selections.
    hi Visual cterm=reverse

    " Make folds less visually distracting.
    hi clear Folded
    hi link Folded Special

    " Disable ugly gray background in side columns.
    hi FoldColumn ctermbg=NONE
    hi SignColumn ctermbg=NONE

    " Make the tabline a bit more minimal.
    hi TabLine ctermbg=NONE ctermfg=darkgray
    hi TabLineFill cterm=NONE ctermbg=235
    hi TabLineSel ctermfg=224

    " Make the statusline a bit more minimal.
    " NOTE: these are effectively disabled by vim-airline.
    hi StatusLine cterm=bold,underline ctermfg=224
    hi StatusLineNC cterm=underline ctermfg=224


" Information Density
    set relativenumber              " Relative numbering!
    set number                      " Show absolute line numbers.
    set ruler                       " Show line lengths in the statusline.
    set cursorline                  " Underline the current line.
    set cursorcolumn                " Mark the current column.
        hi CursorColumn cterm=bold ctermbg=NONE ctermfg=white guibg=NONE guifg=white
                      " ^ bold every character that's in the same column as the cursor

" Place tempfiles in a central location, naming folders by PID.
" This *does* break some of the 'prevent simultaneous editing' enabled by
" swapback files, and it makes recovering lost data a bit harder, but that's a
" worthy price to pay in exchange for `nvim -S` calls that actually work.
" " Taken from: https://github.com/tpope/vim-obsession/issues/18
let vimtmp = $HOME . '/.tmp/' . getpid()
silent! call mkdir(vimtmp, "p", 0700)
let &backupdir=vimtmp
let &directory=vimtmp
