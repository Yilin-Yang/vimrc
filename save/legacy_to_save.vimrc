""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save Old Window State
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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

" Buffer events
augroup buffer_stuff
    au!
    autocmd VimEnter * EditorConfigReload
    autocmd BufWritePre * if &filetype !=# 'vader' | call DeleteTrailing() | endif
    autocmd WinLeave * call LeaveWindow()
    " also on BufEnter, so that opening an unfocused buffer in a new tab will
    " reapply focused settings
    autocmd BufEnter,WinEnter * call ReenterWindow()
    autocmd FileType markdown nnoremap <buffer> <localleader>ll :call MarkdownThis()<cr>
augroup end

" Trigger `autoread` when files change on disk
"   https://unix.stackexchange.com/a/383044
"   https://vi.stackexchange.com/q/13692
augroup autoread
    au!
    autocmd FocusGained, BufEnter, CursorHold, CursorHoldI *
        \ if &buftype !=# 'nofile' && mode() != 'c'
            \ | checktime
        \ | endif
    " Notification after file change
    "   https://vi.stackexchange.com/q/13091
    autocmd FileChangedShellPost *
        \ echohl WarningMsg
        \ | echo 'Detected changes to a loaded file. Buffer may have been reloaded.'
        \ | echohl None
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save Old Window State END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
set mouse=                          " Don't respond to mouse clicks.
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
" " need to set lightline colorscheme before setting |:colorscheme|
let g:lightline = {}
let g:lightline.colorscheme = 'wombat'

colorscheme yilin

syntax on                           " Turn on syntax highlighting.
syntax sync fromstart               " Highlight from the start of the buffer.
set background=dark                 " Make text readable on dark background.
set breakindent                     " Visually indent when softwrapping.
set foldcolumn=1                    " Show a column with all folds.
set nowrap                          " Don't visually wrap lines that are too long.
set list                            " Explicitly render `listchars`.
set listchars=tab:│·,extends:>,precedes:<,nbsp:+
set fillchars+=vert:│

call HighlightTrailing('ErrorMsg')  " Highlight trailing whitespace.

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

" For persistent mark names in vim-markbar.
if has('nvim')
    set shada+=!
else
    set viminfo+=!
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings.vim END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions and Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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

"=============================================================================
"   Window Resizing                                         [WINDOW_RESIZE]
"=============================================================================

" EFFECTS:  Resizes the active split, along a given direction, to a provided
"           size proportional to its current size OR by incrementing/decrementing
"           by an absolute number of rows/cols.
" PARAM:    dimension (string)  Whether to change the split's width or its
"           height. Valid values are 'WIDTH' and 'HEIGHT'.
" PARAM:    change (string OR float)    How much to change the window's size.
"               change (string)         Formatted like '+5' or '-3', *with
"                                           quotes.* Used for
"                                           incrementing/decrementing by an
"                                           absolute number of rows/cols.
"               change (float)          The window's new size, as a proportion
"                                           of vim's current displayable area.
function! ResizeSplit(dimension, change)
    let l:command = 'normal! :'  " build a resize command piece by piece
    if type(a:change) == v:t_string
        let l:change = a:change
    else
        let l:change = string(a:change)
    endif

    if a:dimension ==# 'WIDTH'
        let l:command = l:command . 'vertical resize '
    elseif a:dimension ==# 'HEIGHT'
        let l:command = l:command . 'resize '
    endif

    let l:match = matchstr(l:change, '[+-]')
    if l:match ==# '+' || l:match ==# '-'
        " Regex match detected a plus or minus at the start of the variable,
        " so we're incrementing/decrementing absolutely.
        let l:command = l:command . l:change
    else
        " Assume we were given a floating point proportion.

        if a:dimension ==# 'WIDTH'
            let l:new_size = string(&columns * a:change)
        elseif a:dimension ==# 'HEIGHT'
            let l:new_size = string(&lines * a:change)
        endif
            let l:command = l:command . l:new_size
    endif

    let l:command = l:command . "\<cr>"
    echo l:command

    execute l:command
endfunction

" Resize split to a proportion of its size.
command! -nargs=1 Rs   call ResizeSplit('HEIGHT', <args>)
command! -nargs=1 Vrs  call ResizeSplit('WIDTH', <args>)

"=============================================================================
"   Cosmetic                                                [COSMETIC]
"=============================================================================

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
    call maktaba#ensure#IsString(a:high_grp)
    " initialize the highlight group
    highlight TrailingWhitespace ctermbg=red
    hi clear TrailingWhitespace
    if empty(a:high_grp)
      return
    endif
    execute 'hi link TrailingWhitespace ' . a:high_grp
    match TrailingWhitespace /\s\+$/
endfunction
