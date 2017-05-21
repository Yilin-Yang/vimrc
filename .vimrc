set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" " Local .vimrc settings
Plugin 'embear/vim-localvimrc'
	let g:localvimrc_ask=0
	let g:localvimrc_sandbox=0
	let g:localvimrc_name=['.yvimrc']

" " Syntax checker
Plugin 'scrooloose/syntastic'
"	Syntastic debug
"	let g:syntastic_debug=1
"	set statusline+=%#warningmsg#
"	set statusline+=%{SyntasticStatuslineFlag()}
"	set statusline+=%*

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 0
	let g:syntastic_check_on_wq = 0
	let g:syntastic_c_check_header = 1
	let g:syntastic_c_remove_include_errors = 1
	let g:syntastic_cpp_checkers=['gcc']
	let g:syntastic_cpp_compiler = 'g++'

	let g:syntastic_enable_signs = 1

	" EECS 280 syntax checker
	" let g:syntastic_cpp_compiler_options = '-Wall -Werror --std=c++11'

	" MAAV syntax checker
	let g:syntastic_cpp_compiler_options = '-Wall -Wextra -pedantic -pthread -std=c++14 -g -fPIC'
"

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
	map <C-n> :NERDTreeToggle<CR>

	let NERDTreeQuitOnOpen = 1


Plugin 'tpope/vim-unimpaired'

" " All of your Plugins must be added before the following line
call vundle#end()	        " required

filetype plugin indent on	" required, filetype detect, indenting per lang
" " To ignore plugin indent changes, instead use:
" "filetype plugin on

" " Brief help
" " :PluginList	   - lists configured plugins
" " :PluginInstall	- installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean	  - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" MAAV formatting
set noexpandtab " Tabs for indentation
set tabstop=4 " Tabs are four spaces wide
set shiftwidth=4

autocmd BufWritePre * :%s/\s\+$//e "Delete trailing whitespace on save

" Personal stuff
set backspace=indent,eol,start " Sane backspace
syntax on " Turn on syntax highlighting
set background=dark " Make text readable on dark background
set number " Show line numbers
set hidden " Allow hidden buffers, not limited to 1 file/window

" Decrease timeout for combined keymaps
set timeoutlen=50

" Highlight text going past 80 chars on one line
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Enable paste-mode that doesn't autotab
set pastetoggle=<F2>

" Split view!
" Ctrl + HJKL to cycle through windows!
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

" Exit interactive mode by hitting j and k at the same time
inoremap jk <esc>

" vim specific, not needed for nvim
if !has('nvim')
	" Alt key can now be used as modifier (sends Escape character)
	execute "set <M-d>=\ed"
	execute "set <M-a>=\ea"

endif

" nvim specific, not needed for vim
if has('nvim')
	" Map j and k to exiting terminal mode
	tnoremap jk <C-\><C-n>
	" Ditto with ESC
	tnoremap <Esc> <C-\><C-n>

	" Control plus HJKL to move between windows in terminal mode
	tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l
endif

" Tabs!
" Alt + AD to move through tabs!
"noremap <A-w> :tabr<cr>
"noremap <A-s> :tabl<cr>
nnoremap <M-a> :tabp<cr>
nnoremap <M-d> :tabn<cr>

" Plus and minus to open and close tabs
nnoremap = :tabnew<cr>:NERDTreeToggle<CR>
nnoremap - :tabclose<cr>

" Shift + Up/Down to scroll
"noremap <S-Up> <C-u>
"noremap  <C-d>

" FOR THE LOVE OF GOD STOP BOOPING
set visualbell " oh praise jesus

" In normal map mode, press Ctrl-C to save buffer and run Syntastic check
" backslash is necessary to escape pipe character
nnoremap <C-c> :w \| :SyntasticReset \| :SyntasticCheck<cr>

" In normal map mode, press Ctrl-Q to close Syntastic error window
nnoremap <C-z> :SyntasticReset<cr>

" In normal map mode, press Ctrl-X to erase currently selected word
nnoremap <C-x> diw

" Ctrl-Backspace deletes the previous word
inoremap <C-BS> <C-w> " Doesn't work, unfortunately; terminal bug?
