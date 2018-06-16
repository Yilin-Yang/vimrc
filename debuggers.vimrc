"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   GENERAL                                                 [GENERAL]
"
"   lldb                                                    [LLDB]
"   ConqueGDB                                               [CONQUEGDB]
"   vim-vebugger                                            [VEBUGGER]
"=============================================================================

"=============================================================================
"   GENERAL                                                 [GENERAL]
"=============================================================================
"   Debugger keybindings used by all of my debugger plugins.
"=============================================================================

"-------------------------------------------------------------------------
"   Common Keybindings
"-------------------------------------------------------------------------
" 'Prefix key' for some keybindings.
fu! DebuggerPrefix()
    return '<Leader>d'
endf

fu! DebuggerSetBreakpoint()
    return '<Leader>b'
endf

fu! DebuggerContinue()
    return '<F8>'
endf

" Analogous to hitting Ctrl-C while running GDB.
fu! DebuggerInterrupt()
    return '<F7>'
endf

fu! DebuggerToStdin()
    return '<F4>'
endf

" Print the value of the currently selected word.
fu! DebuggerEvaluate()
    return '<F9>'
endf

fu! DebuggerStepIn()
    return '+'
endf

fu! DebuggerStepOver()
    return '='
endf

fu! DebuggerKill()
    return 'k'
endf

"=============================================================================
"   lldb                                                    [LLDB]
"=============================================================================
function! StartLLDB()
"-------------------------------------------------------------------------
" Starts LLDB debugger session.
execute 'nnoremap <silent> ' . DebuggerPrefix() . 'n' . ' :LLsession new<cr>'

" Starts LLDB debugger session and immediately switches to debug mode.
execute 'nnoremap <silent> ' . DebuggerPrefix() . 'd' . ' :LLsession new<cr>:LLmode debug<cr>'

" Loads the (default) existing LLDB debugger session.
execute 'nnoremap <silent> ' . DebuggerPrefix() . 'e' . ' :LLsession load<cr>:LLmode debug<cr>'

" Reloads the current debugger session from the file.
execute 'nnoremap <silent> ' . DebuggerPrefix() . 'r' . ' :LLsession reload<cr>'

" Shows the current session file.
execute 'nnoremap <silent> ' . DebuggerPrefix() . 'l' . ' :LLsession show<cr>'
"-------------------------------------------------------------------------


"-------------------------------------------------------------------------
" Save existing breakpoints.
execute 'nnoremap <silent> ' . DebuggerPrefix() . 's' . ' :LLsession bp-save<cr>'

" Load breakpoints that were defined in the session state.
execute 'nnoremap <silent> ' . DebuggerPrefix() . 'o' . ' :LLsession bp-save<cr>'
"-------------------------------------------------------------------------

" Switch to debug mode.
execute 'nnoremap          ' . DebuggerPrefix() . 'md' . ' :LLmode debug<cr>'

" Switch to code mode.
execute 'nnoremap          ' . DebuggerPrefix() . 'c' . ' :LLmode code<cr>'
execute 'nnoremap          ' . DebuggerPrefix() . DebuggerKill() . ' :LL process kill<cr>:LLmode code<cr>'

"-------------------------------------------------------------------------
" NOTE: these mappings can't be 'nore', since they have to invoke other
"       mappings.
"-------------------------------------------------------------------------
" Set breakpoint on current line.
execute 'nmap <silent>' . DebuggerSetBreakpoint() . ' <Plug>LLBreakSwitch'

" Send selected text to stdin.
execute 'vmap <silent>' . DebuggerToStdin()       . ' <Plug>LLStdInSelected'

"-------------------------------------------------------------------------
" NOTE: file redirection doesn't work like it does in GDB. You have to
"       start LLDB and start the program with:
"               process launch -i <filename> -- <program's arguments>
"                                            ^ end of arguments to `process
"                                               launch`
"                               ^ redirect the given file to stdin
"-------------------------------------------------------------------------

"-------------------------------------------------------------------------
" NOTE: setting conditional breakpoints in LLDB is annoying, but useful.
"
"       1)  Set a breakpoint and note its number. Assume it's 3, for sake of
"           example.
"       2)  The following will modify that breakpoint to be a conditional
"           breakpoint, that only fires if the given condition is true.
"               :LL br mod -c '(obj.mem == 3) && (obj.other_mem == 2)' 3
"                   ^ breakpoint
"                      ^ modify
"                           ^ condition
"-------------------------------------------------------------------------
" Prompt the user for something to send to stdin.
" Sends a newline character at the end of the input line.
nnoremap <silent> <Leader><F4> :LLstdin<cr>

execute 'nnoremap <silent> ' . DebuggerContinue()   .   ' :LL continue<cr>'
execute 'nnoremap <silent> ' . DebuggerInterrupt()  .   ' :LL process interrupt<cr>'
execute 'nnoremap          ' . DebuggerEvaluate()   .   ' :LL print <C-R>=expand("<cword>")<cr>'
execute 'vnoremap          ' . DebuggerEvaluate()   .   ' :<C-U>LL print <C-R>=lldb#util#get_selection()<cr><cr>'

" Step in.
execute 'nnoremap <silent> ' . DebuggerStepIn()     .   ' :LL step<cr>'

" Step over.
execute 'nnoremap <silent> ' . DebuggerStepOver()   .   ' :LL next<cr>'

"-------------------------------------------------------------------------
hi link LLSelectedPCSign Underlined

let g:lldb#sign#bp_symbol='B>'
let g:lldb#sign#pc_symbol='->'

"-------------------------------------------------------------------------
endfunction " StartLLDB


"=============================================================================
"   ConqueGDB                                               [CONQUEGDB]
"=============================================================================

" Run the program.
" DEFAULT: let g:ConqueGdb_Run = g:ConqueGdb_Leader . 'r'

function! StartConqueGDB()
"-------------------------------------------------------------------------
" Set ConqueGDB leader key.
let g:ConqueGdb_Leader      = DebuggerPrefix()

" Continue execution.
let g:ConqueGdb_Continue    = DebuggerContinue()

let g:ConqueGdb_Next        = DebuggerStepOver()

let g:ConqueGdb_Step        = DebuggerStepIn()
let g:ConqueGdb_Print       = DebuggerEvaluate()
let g:ConqueGdb_ToggleBreak = DebuggerSetBreakpoint()
let g:ConqueTerm_SendVisKey = DebuggerToStdin()
let g:ConqueTerm_ToggleKey  = DebuggerPrefix() . 'p'


" Starts GDB debugger session.
execute 'nnoremap ' . DebuggerPrefix() . 'd'
    \ . ' :ConqueGdb -d . --args ' . expand('%:r')

execute 'nnoremap ' . DebuggerPrefix() . 's' . ' :ConqueGdbCommand '

execute 'nnoremap ' . DebuggerPrefix() . DebuggerKill() . ' :ConqueGdbCommand q<cr>:ConqueGDBDelete<cr>'

" This shouldn't be necessary (should be handled by vim-plug's lazy-load),
" but lazy-loading doesn't seem to work without it.
call plug#load('Conque-GDB')
"-------------------------------------------------------------------------
endfunction " StartConqueGDB

" Start ConqueGDB with a command rather than a function call.
command! -nargs=0 StartConqueGDB call StartConqueGDB()


"=============================================================================
"   vim-vebugger                                            [VEBUGGER]
"=============================================================================

"-----------------------------------------------------------------------------
" EFFECTS:  Starts the given debugger with the given executable
"           and the given arguments, if any. Sets my standard debugger
"           keybindings. Enables vebugger's keybindings using DebuggerPrefix
"           as g:vebugger_leader.
" PARAM:    debugger    The debugger to launch. Valid debuggers include:
"                       GDB, LLDB, PDB.
" PARAM:    test_exe    The executable file to open in the debugger.
" PARAM:    ...         Any additional arguments to provide to test_exe.
"                       Due to the constraints of VimL:
"                           0 <= num_additional_args <= 18
" NOTE:     Other vebugger implementations use a call syntax resembling:
"               call vebugger#[DEBUGGER]#start('test_exe', args{...
"           Accessing these will require that you write another function.
"-----------------------------------------------------------------------------
function! StartVebugger(debugger, test_exe, ...)
    let l:test_args = ' '
    for l:val in a:000
        let l:test_args .= l:val . ' ' " concatenate
    endfor

    execute ':VBGstart' . a:debugger . ' ' . a:test_exe . l:test_args

    let g:vebugger_leader=DebuggerPrefix()

"-------------------------------------------------------------------------
" Set breakpoint on current line.
execute 'nnoremap '          . DebuggerSetBreakpoint() . ' :VBGtoggleBreakpointThisLine<cr>'

" Prompt user for text to se nd to the terminal.
execute 'nnoremap '          . DebuggerToStdin()       . ' :VBGrawWrite<cr>'
execute 'vnoremap '          . DebuggerToStdin()       . ' :VBGrawWriteSelectedText<cr>'

" Continue.
execute 'nnoremap <silent> ' . DebuggerContinue()      . ' :VBGcontinue<cr>'
execute 'nnoremap <silent> ' . DebuggerEvaluate()      . ' :VBGevalWordUnderCursor<cr>'
execute 'vnoremap <silent> ' . DebuggerPrefix()        . DebuggerEvaluate() . ' :VBGevalSelectedText<cr>'

" Step in.
execute 'nnoremap <silent> ' . DebuggerStepIn()        . ' :VBGstepIn<cr>'

" Step over.
execute 'nnoremap <silent> ' . DebuggerStepOver()      . ' :VBGstepOver<cr>'

" Toggle terminal buffer.
execute 'nnoremap <silent> ' . DebuggerPrefix()        . 't'                . ' :VBGtoggleTerminalBuffer<cr>'

" Kill vebugger session.
execute 'nnoremap <silent> ' . DebuggerPrefix()        . DebuggerKill()     . ' :VBGkill<cr>'

"-------------------------------------------------------------------------

endfunction " StartVebugger
