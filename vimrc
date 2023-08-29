scriptencoding utf-8

"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   Keybinds                                                    [KEYBINDS]
"   Commands                                                    [COMMANDS]
"   Settings                                                    [SETTINGS]
"   Buffer Events                                               [BUFFER]


"=============================================================================
"   Keybinds                                                    [KEYBINDS]
"=============================================================================

" Ctrl + hjkl to cycle through windows!
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Write the current buffer by double-tapping the leader key.
nnoremap <leader><leader> :w<cr>

" Exit interactive/visual mode by hitting j and k.
inoremap jk <esc>
vnoremap jk <esc>

" Replace the word currently under the cursor. Mash `.` to continue
" substituting instances of this word.
" " Taken from:
" "     https://www.reddit.com/r/vim/comments/8k4p6v/what_are_your_best_mappings/dz5aoi9/
nnoremap <Leader>x /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <Leader>X ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

" cd into the directory of the current buffer.
" " Taken from the following link, with slight modifications:
" "     https://www.reddit.com/r/vim/comments/8k4p6v/what_are_your_best_mappings/dz4s39k/
nnoremap <leader>tcd :tcd %:p:h<CR>:pwd<CR>
nnoremap <leader>lcd :lcd %:p:h<CR>:pwd<CR>
nnoremap <leader>cd  :cd  %:p:h<CR>:pwd<CR>

if has('nvim')
    " " nvim specific, not needed for vim.
    " Map j and k to exiting terminal mode.
    tnoremap jk <C-\><C-n>

    " Ditto with ESC.
    tnoremap <Esc> <C-\><C-n>

    " Control plus HJKL to move between windows in terminal mode.
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l
else
    " " vim specific, not needed for nvim.

    " Enable use of Alt key as modifier (sends Escape character).
    execute "set <M-d>=\ed"
    execute "set <M-a>=\ea"
endif

" Scroll laterally by large amounts.
nnoremap H 40h
nnoremap L 40l

" Alt + A/D to move through tabs
nnoremap <silent> <M-a> :tabprevious<cr>
nnoremap <silent> <M-d> :tabnext<cr>

" Alt + E/Q to open/close tabs
nnoremap <silent> <M-e> :tabnew<cr>
nnoremap <silent> <M-q> :tabclose<cr>

" Alt + N/C to open/close tabs
nnoremap <silent> <M-n> :tabnew<cr>
nnoremap <silent> <M-c> :tabclose<cr>

" Alt + H to clear highlights and error windows
nnoremap <silent> <M-h> :cclose<cr>:lclose<cr>:noh<cr>:echo "Cleared highlights and closed quickfix/location list."<cr>

function! IsQuickfixOpen() abort
    let l:is_open = 0
    for l:winnr in range(1, winnr('$'))
        if getwinvar(l:winnr, '&syntax') == 'qf'
            let l:is_open = 1
            break
        endif
    endfor
    return l:is_open
endfunction

function! ToggleQuickfix() abort
    if IsQuickfixOpen()
        cclose
    else
        copen
    endif
endfunction

nnoremap <silent> <leader>q :call ToggleQuickfix()<cr>


" Exit the rabbit hole
" " (If you dug too deep into a location list, etc.)
nnoremap <silent> <leader>^ :e#1<cr>

" Sort the highlighted lines.
vnoremap <silent> <leader>s :sort<cr>

"=============================================================================
"   Commands                                                    [COMMANDS]
"=============================================================================
"
" Open the given helpdoc in a vertical split.
command! -nargs=1 Help execute ':vert h <args>'

" So that I can just type ':H <whatever>'. netrw defines this but I don't
" use it.
delcommand Hexplore

""
" Deletes all trailing whitespace in the active file, returning
" the cursor to its old location afterwards.
function! DeleteTrailing()
    let l:old_contents = @"
    let l:old_search = @/

    let l:cur_pos = getcurpos()

    " This raw substitution command breaks syntax highlighting for the rest of
    " the file, but it doesn't work when wrapped in ':execute' or ':normal'.
    %s/\s\+$//e

    call setpos('.', l:cur_pos)

    let @/ = l:old_search
    let @" = l:old_contents
endfunction

" EFFECTS:  Redirects the output of the given vim command into a
"           scratch buffer.
" USAGE:    :Redir hi ............. show the full output of command ':hi' in a
"                                   scratch window
"           :Redir !ls -al ........ show the full output of command ':!ls -al'
"                                   in a scratch window
" DETAILS:  Taken from:
"               https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! Redir(cmd)
    for l:win in range(1, winnr('$'))
        if getwinvar(l:win, 'scratch')
            execute l:win . 'windo close'
        endif
    endfor
    if a:cmd =~# '^!'
        execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
    else
        redir => l:output
        execute a:cmd
        redir end
    endif
    vnew
    let w:scratch = 1
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(l:output, "\n"))
endfunction

command! -nargs=1 Redir silent call Redir(<f-args>)

" EFFECTS:  Sets a colorcolumn for every column in the specified range
"           (`[start, end]`) OR every column from `start`
"           onwards (`[start, +inf)`).
" PARAM:    start (v:t_number)      The first column to highlight.
" PARAM:    end (v:t_number)        The last column to highlight (inclusive).
"                                       Defaults to +inf (actually 255, which
"                                       is the maximum possible value in vim.)
" PARAM:    hi_args (v:t_string)    The highlight arguments to be applied to
"                                       the ColorColumn highlight group
"                                       (e.g. `ctermg=1 guibg=DarkRed`). Set
"                                       to the null string (`''`) by default,
"                                       which leaves ColorColumn unchanged
"                                       from its present value.
" DETAIL:   Taken from the following link:
"               https://blog.hanschen.org/2012/10/24/different-background-color-in-vim-past-80-columns/
function! ColorColumnBlock(...) abort
    let l:num_args  = get(a:, 0)
    let l:start     = get(a:, 1, 0)
    let l:end       = get(a:, 2, 255)
    let l:hi_args   = get(a:, 3, '')

    if l:num_args ==# 0
        echoerr 'No args provided to ColorColumnBlock!'
        return
    endif

    if strlen(l:hi_args)
        execute 'hi ColorColumn ' . l:hi_args
    endif
    execute 'set colorcolumn=' . join(range(l:start,l:end), ',')
endfunction

" EFFECTS:  Highlights trailing whitespace.
" PARAM:    high_grp  (v:t_string)  The highlight group to apply to detected
"                                       trailing whitespace. If empty, stops
"                                       highlighting trailing whitespace.
function! HighlightTrailing(high_grp) abort
    if type(a:high_grp) !=# 1
        echoerr "Highlight group name not a string!"
    endif
    if empty(a:high_grp)
      return
    endif
    execute 'hi link TrailingWhitespace ' . a:high_grp
    match TrailingWhitespace /\s\+$/
endfunction

""
" Return a dict between window settings to be modified and their current values.
"
" {vars_and_new_vals} is a list of key-value pairs: the setting to be
" modified, and its new value (which is ignored).
function! WindowState(vars_and_new_vals) abort
  " get only the setting names
  let l:vars = map(copy(a:vars_and_new_vals), 'v:val[0]')
  call map(l:vars, '"&".v:val')
  let l:state = {}
  let l:winnr = winnr()
  for l:var in l:vars
    let l:state[l:var] = getwinvar(l:winnr, l:var)
  endfor
  return l:state
endfunction

""
" Save the current values of window settings, change those variables as we
" wish, but store the old values as a window variable.
function! LeaveWindow() abort
  let l:to_set = [
      \ ['number', 0],
      \ ['relativenumber', 0],
      \ ['foldcolumn', 0],
      \ ['signcolumn', 'auto:1'],
      \ ]
  let w:winstate = WindowState(l:to_set)
  let l:winnr = winnr()
  for [l:setting, l:val] in l:to_set
    call setwinvar(l:winnr, '&'.l:setting, l:val)
  endfor
endfunction

""
" Restore old window settings to the values they had before we left.
function! ReenterWindow() abort
  if !exists('w:winstate')
    return
  endif
  let l:winnr = winnr()
  for [l:setting, l:val] in items(w:winstate)
    call setwinvar(l:winnr, l:setting, l:val)
  endfor
  unlet w:winstate
endfunction

"=============================================================================
"   Settings                                                    [SETTINGS]
"=============================================================================

set relativenumber      " Relative numbering!
set number              " Show absolute line numbers.
set ruler               " Show line lengths in the statusline.
set nocursorline        " Don't underline the current line.
set cursorcolumn        " Mark the current column.

set expandtab           " Spaces for indentation.
set shiftwidth=2        " Indentation depth with << and >> commands.
set softtabstop=-1      " The number of columns to insert when pressing <Tab>.
                        " (Negative value => use value of `shiftwidth`.)
set tabstop=8           " By default, most editors come configured with a
                        " default tab-width of 8 columns, and
                        " having that width set differently can make files
                        " written in those editors look weird.

set foldlevel=20        " Fully expand all document folds on open.
set nowrap
set hlsearch            " Highlight matching strings when searching.

set clipboard=unnamed   " Don't 'exchange' "+ contents with overwritten text.

call ColorColumnBlock(80, 255, 'ctermbg=236')

" Explicitly render `listchars`.
set list
set listchars=tab:│·,extends:>,precedes:<,nbsp:+
set fillchars+=vert:│

" I literally never use swapfiles, and I habitually save my files every
" fifteen seconds or so.
set noswapfile

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

" For persistent mark names in vim-markbar.
if has('nvim')
    set shada+=!
else
    set viminfo+=!
endif

" NOTES: this doesn't work with the default colorscheme
" call HighlightTrailing('ErrorMsg')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Buffer Events                                               [BUFFER]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Buffer events
augroup buffer_stuff
    au!
    autocmd BufWritePre * if &filetype !=# 'vader' | call DeleteTrailing() | endif
    autocmd WinLeave * call LeaveWindow()
    " also on BufEnter, so that opening an unfocused buffer in a new tab will
    " reapply focused settings
    autocmd BufEnter,WinEnter * call ReenterWindow()
augroup end
