" Generated using vimscript from the following link:
"   https://vi.stackexchange.com/a/4496

" Open two files in a vsplit.
BufReadPre
Syntax
FileType
BufRead
BufReadPost
BufWinEnter

Syntax
FileType

BufEnter

BufReadPre
Syntax
FileType
BufRead
BufReadPost
BufWinEnter

WinEnter
Syntax
FileType
BufEnter
VimEnter
CursorMoved
FocusGained

" <C-w><C-l> into the other split.
BufLeave
WinLeave
WinEnter
Syntax
FileType
BufEnter


QuitPre
BufWinLeave
BufWinLeave
BufUnload
BufUnload
VimLeavePre
VimLeave
