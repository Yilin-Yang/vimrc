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
    autocmd BufWritePre * if &filetype !=# 'vader' | call DeleteTrailing() | endif
    autocmd WinLeave * call LeaveWindow()
    autocmd WinEnter * call ReenterWindow()
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

" Perform certain actions the first time a user's cursor enters a buffer.
"
" Did this because `WinEnter` seems to be the first autocmd that fires late
" enough that global options (like `foldmethod`) can take effect beforehand.
" `WinEnter` does not fire once per buffer, hence the buffer-local flag.
"
" Adapted from:
"   http://vim.wikia.com/wiki/Folding#Indent_folding_with_manual_folds
augroup firstread
    au!
    autocmd BufReadPre,BufWinEnter * silent let b:firstread = 1

    " Add additional commands to the if-statement below.
    " Use :silent! to prevent annoying error messages when opening an unnamed
    " buffer, leaving a NERDtree buffer, etc.
    autocmd WinEnter *
        \ silent! if b:firstread
            \ | setlocal foldmethod=manual
        \ | endif

    autocmd BufLeave * silent! if b:firstread | let b:firstread = 0 | endif
augroup end
