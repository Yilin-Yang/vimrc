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

" " Fugitive
" " Wrapper for git.
"
" Usage:
" 	:Gstatus
" 		- to add-reset a file's changes
" 		p to add-reset a patch
" 	:Gcommit	=	commit changes to the current file
" 	:Gblame		=	open interactive vertical split with git blame
" 					press enter on a line to edit the command where the line
" 						changed, or o to open in a split
" 	:Gedit		=	in the historic buffer to return to the work tree version
"
" 	:Gmove		=	automatic git mv and renames the buffer
" 	:Gdelete	=	automatic git rm and deletes the buffer
"
" 	:Ggrep		=	searches the work tree with git grep, skipping whatever's
" 						not tracked in the repo
" 	:Glog		=	loads all previous revisions into the quickfix list,
" 						can iterate over them
" 	:Gread		=	git checkout -- {active file} that operates on the buffer,
" 						not the file itself
"
"	:Gwrite		=	like git add when called from a working tree file, like
"						git checkout when called from an index/blob from
"						history
"
"	:Git		=	run an arbitrary command
"	:Git!		=	run an arbitrary command and open output in a temp file
Plugin 'tpope/vim-fugitive'

" " Easily modify the characters surrounding a particular word
"
" Usage:
"	cs"'		=	change surroundings (from) " to '
"	cs'<q>		=	change surroundings (from) ' to <q> ... </q>
"	cst"		=	change surroundings TO "
"	ds"			=	delete (from) surroundings "
"	ysiw]		=	YOOM surroundings (in word) ], producing [foo]
"	cs]{		=	change surroundings (from) ] to {fooOO, producing { foo }
"	cs]}		=	change surroundings (from) ] to }, producing {foo}
"	yss)		=	YOOM the entire line with )
"	ds{ds)		=	delete surroundings {ooOO, then delete surroundings )
"
"	In visual mode,
"		V						=	line-wise visual select
"		S<p class"important">	=	SURROUND with this HTML tag
""	Produces:
"		<p class="important">
"		  <em>Hello</em> world!
"		</p>
Plugin 'tpope/vim-surround'


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
	" nnoremap ]l :lnext
	" nnoremap [l :lprev

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
	map <C-n> :NERDTreeToggle<cr>

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
	if search("BOOST")
		" If I'm writing Boost test cases, format the function headers differently
		%s/BOOST_AUTO_TEST_CASE(\(.*\))/BOOST_AUTO_TEST_CASE(\1)\r{\r\tBOOST_TEST_MESSAGE("\1");\r\t\r\tBOOST_CHECK_MESSAGE(,"\1 failed!");\r}\r
	else
		" But, if I'm just writing generic test cases for a class,
		search("int main") " Don't reformat the forward declarations
		.,$s/void \(\<\w\+\>\)();\n/void \1()\r{\r\tcout << "\1" << endl;\r\r\tcout << "\1 PASSED" << endl;\r\}\r
	endif

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

" Fold everything indented past this fold-level.
function RecursiveFoldPast(level)
	setlocal foldmethod=indent
	let &l:foldlevel = a:level
endfunction

" Fold everything indented at this level.
function FoldAt(level)
	let &l:foldnestmax=a:level + 1
	call RecursiveFoldPast(a:level)
	"%foldo
endfunction

" Write the current buffer and run Neomake's syntax checker.
" Also, stop vim from reclosing folds when Neomake shows the quickfix list.
function WriteAndLint()
	" setlocal foldmethod=manual
	w
	call CloseErrorWindows()
	Neomake
	" setlocal foldmethod=syntax
endfunction

" Fold all of the function implementations in the current file.
function FoldFunctionBodies()
	setlocal foldmethod=indent
	if &foldlevel !=? 20
		setlocal foldlevel=20
	else
		" Expand the name of just this file, see what filetype it is
		let filename = expand('%:t')
		if match(filename, "hpp") !=? -1 || match(filename, "h") !=? -1
			setlocal foldlevel=1
		else
			setlocal foldlevel=0
		endif
		let l:foldnestmax=&foldlevel + 1
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
set backspace=indent,eol,start		" Sane backspace
syntax on							" Turn on syntax highlighting
set background=dark					" Make text readable on dark background
set relativenumber					" Relative numbering!
set number							" Show line numbers
set ruler							" Show line lengths
set nohidden						" Allow hidden buffers, not limited to 1 file/window
set visualbell						" FOR THE LOVE OF GOD STOP BOOPING IN WSL
set showcmd							" See leader key in corner
set colorcolumn=81 					" My personal line limit
set foldcolumn=1					" Show a column with all folds

" Decrease timeout for combined keymaps
set timeoutlen=200					" vim-surround keybindings takes a while

" Enable paste-mode that doesn't autotab
set pastetoggle=<F2>


" C++ Formatting
" .cpp files
" augroup cpp_fold
" 	au!
" 	autocmd BufEnter,BufNew *.cpp call FoldAt(0) " FileType cpp includes headers
" 	autocmd BufEnter,BufNew *.hpp call FoldAt(2)
" augroup end


" Buffer events
augroup buffer_stuff
	au!
	autocmd BufWritePre * :%s/\s\+$//e "Delete trailing whitespace on save
	" autocmd BufRead * :call Highlight() " highlight overlength on buffer read
	" autocmd BufReadPost,BufWritePost,BufEnter * :Neomake
	" autocmd BufUnload * :call CloseErrorWindows() " close windows upon leaving buffer
augroup END

nnoremap dr :call DiffgetRe()<cr>
nnoremap dn /<<<<<cr><C-d>N
nnoremap dq :call ExitMergeResolutionIfDone()<cr>

" Toggle Fold Functions
nnoremap <F5> :call FoldFunctionBodies()<cr>

" Ctrl + hjkl to cycle through windows!
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-\><C-N><C-w>hi
inoremap <C-j> <C-\><C-N><C-w>ji
inoremap <C-k> <C-\><C-N><C-w>ki
inoremap <C-l> <C-\><C-N><C-w>li

" Exit interactive mode by hitting j and k
inoremap jk <esc>

" Ditto visual mode
vnoremap jk <esc>

" vim specific, not needed for nvim
if !has('nvim')
	" Alt key can now be used as modifier (sends Escape character)
	execute "set <M-d>=\ed"
	execute "set <M-a>=\ea"
else " nvim specific, not needed for vim
	" Map j and k to exiting terminal mode
	tnoremap jk <esc>

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
nnoremap <M-n> :tabnew<cr>:NERDTreeToggle<cr>
nnoremap <M-c> :tabclose<cr>

nnoremap <M-h> :call CloseErrorWindows()<cr>:noh<cr>:echo "Cleared highlights."<cr>

" Number row zero and +/- to open and close tabs
nnoremap 0= :tabnew<cr>:NERDTreeToggle<cr>
nnoremap 0- :tabclose<cr>

" In normal map mode, press Ctrl-X to activate clipboard register
nnoremap <C-x> "+:echo "SYSTEM CLIPBOARD REGISTER"<cr>
