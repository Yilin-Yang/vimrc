set nocompatible
filetype off

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

if !has('nvim')
	" " Syntax checker
	Plugin 'scrooloose/syntastic'
		" In normal map mode, press Ctrl-C to save buffer and run Syntastic check
		" backslash is necessary to escape pipe character
		nnoremap <C-c> :w \| :SyntasticReset \| :SyntasticCheck<cr>

		" In normal map mode, press Ctrl-Z to close Syntastic error window
		nnoremap <C-z> :SyntasticReset<cr>

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
else
	" For some reason, unimpared doesn't work in neovim?
	nnoremap ]l :lnext
	nnoremap [l :lprev

	" " Asynchronous syntax checker
	Plugin 'neomake/neomake'
		" In normal map mode, press Ctrl-C to save buffer and run Syntastic check
		" backslash is necessary to escape pipe character
		nnoremap <C-c> :w \| :call CloseErrorWindows() \| :Neomake \| :call Highlight() <cr>

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
			\ 'args': '-Wall -Wextra -pedantic -pthread -std=c++14 -g -fPIC',
			\ }
		let g:neomake_cpp_enable_makers = ['gcc']

endif

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

" Functions

function Highlight()
	" Highlight text going past 80 chars on one line
	highlight OverLength ctermbg=DarkRed ctermfg=white guibg=#592929
	match OverLength /\%81v.\+/
endfunction

function CloseErrorWindows()
	" Closes quickfix list and locations list
	cclose
	lclose
endfunction

function TestCaseAutoformat()
	" Takes void function header prototypes from cursor to EOF,
	" formats them as function declarations, and adds in cout statements
	"
	" TODO: don't reformat function header prototypes from before the main
	" method
	.,$s/void \(\<\w\+\>\)();\n/void \1()\r{\r\tcout << "\1" << endl;\r\r\tcout << "\1 PASSED" << endl;\r\}\r
	noh " stop highlighting matched function headers after the above call
endfunction

function Tca()
	" Shorter alias for TestCaseAutoformat
	call TestCaseAutoformat()
endfunction

" Functions for merge conflict resolution

function DiffgetLo()
	" filler is default and inserts empty lines for sync
	set diffopt=filler,context:1000000
	diffget LO
endfunction

function DiffgetRe()
	" filler is default and inserts empty lines for sync
	set diffopt=filler,context:1000000
	diffget RE
endfunction

function ExitMergeResolutionIfDone()
	if search("<<<<<<<") || search(">>>>>>>")
		echoerr "Still conflicts to resolve!"
	else
		wq | qa
	endif
endfunction

" MAAV formatting
set noexpandtab " Tabs for indentation
set tabstop=4 " Tabs are four spaces wide
set shiftwidth=4

" Colorscheme
colorscheme default " For now, all this does is trigger the autocmd for changing
					" Neomake's highlight colors

" Personal stuff
set backspace=indent,eol,start " Sane backspace
syntax on " Turn on syntax highlighting
set background=dark " Make text readable on dark background
set relativenumber " Relative numbering!
set number " Show line numbers
set ruler " Show line lengths
set nohidden " Allow hidden buffers, not limited to 1 file/window
set visualbell " FOR THE LOVE OF GOD STOP BOOPING IN WSL

set colorcolumn=81 " Visual indicator of my personal line length limit

" Buffer events
augroup buffer_stuff
	au!
	autocmd BufWritePre * :%s/\s\+$//e "Delete trailing whitespace on save
	" autocmd BufRead * :call Highlight() " highlight overlength on buffer read
	" autocmd BufReadPost,BufWritePost,BufEnter * :Neomake
	" autocmd BufUnload * :call CloseErrorWindows() " close windows upon leaving buffer
augroup END

" Decrease timeout for combined keymaps
set timeoutlen=125

" Enable paste-mode that doesn't autotab
set pastetoggle=<F2>

" Make merge conflict resolution less agonizing
if &diff                             " only for diff mode/vimdiff
endif

nnoremap dl :call DiffgetLo()<CR>
nnoremap dr :call DiffgetRe()<CR>
nnoremap dn /<<<<<CR><C-d>N
nnoremap dq :call ExitMergeResolutionIfDone()<CR>

" Split view!
" Ctrl + hjkl to cycle through windows!
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-\><C-N><C-w>hi
inoremap <C-j> <C-\><C-N><C-w>ji
inoremap <C-k> <C-\><C-N><C-w>ki
inoremap <C-l> <C-\><C-N><C-w>li

" Exit interactive mode by hitting j and k at the same time
" (df works too, because hand pain)
inoremap jk <esc>
inoremap kj <esc>
inoremap df <esc>
inoremap fd <esc>

" Ditto visual mode
vnoremap jk <esc>
vnoremap kj <esc>
vnoremap df <esc>
vnoremap fd <esc>

" vim specific, not needed for nvim
if !has('nvim')
	" Alt key can now be used as modifier (sends Escape character)
	execute "set <M-d>=\ed"
	execute "set <M-a>=\ea"
else " nvim specific, not needed for vim
	" Map j and k to exiting terminal mode
	tnoremap jk <C-\><C-n>
	tnoremap kj <C-\><C-n>
	tnoremap df <C-\><C-n>
	tnoremap fd <C-\><C-n>
	" Ditto with ESC
	tnoremap <Esc> <C-\><C-n>

	" Control plus HJKL to move between windows in terminal mode
	tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l
endif

" Tabs!
" Alt + A/D to move through tabs!
nnoremap <M-a> :tabp<cr>
nnoremap <M-d> :tabn<cr>

" Alt + J/K to move through tabs!
nnoremap <M-j> :tabp<cr>
nnoremap <M-k> :tabn<cr>

" Alt + N/C to open/close tabs!
nnoremap <M-n> :tabnew<cr>:NERDTreeToggle<CR>
nnoremap <M-c> :tabclose<cr>

nnoremap <M-h> :noh<cr>:echo "Cleared highlights."<cr>

" Number row zero and +/- to open and close tabs
nnoremap 0= :tabnew<cr>:NERDTreeToggle<CR>
nnoremap 0- :tabclose<cr>

" In normal map mode, press Ctrl-X to activate clipboard register
nnoremap <C-x> "+:echo "SYSTEM CLIPBOARD REGISTER"<cr>
