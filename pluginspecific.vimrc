"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   localvimrc                                              [LOCALVIMRC]
"   Neomake                                                 [NEOMAKE]
"   NerdTree                                                [NERDTREE]
"   Tagbar                                                  [TAGBAR]
"   nvim-completion-manager                                 [NCM]
"   vim-easytags                                            [EASYTAGS]
"   vimtex                                                  [VIMTEX]
"   UltiSnips                                               [ULTISNIPS]
"   LanguageClient-neovim                                   [LSP]
"   BufExplorer                                             [BUFFER]
"   vim-repeat                                              [REPEAT]
"   vim-easymotion                                          [EASYMOTION]
"   vim-commentary                                          [COMMENTARY]
"   tabular                                                 [TABULAR]
"   vim-lexical                                             [LEXICAL]
"   vim-easy-align                                          [EASYALIGN]
"   ReplaceWithRegister                                     [REPLACEREGISTER]
"=============================================================================


"=============================================================================
"   localvimrc                                              [LOCALVIMRC]
"=============================================================================
let g:localvimrc_ask=0
let g:localvimrc_sandbox=0
let g:localvimrc_name=['.yvimrc', '.lvimrc']

"=============================================================================
"   Neomake                                                 [NEOMAKE]
"=============================================================================
" In normal map mode, press Ctrl-C to save buffer and run Syntastic check
" backslash is necessary to escape pipe character
" nnoremap <silent> <C-c> :w \| :call CloseErrorWindows() \| :Neomake \| :call Highlight() <cr>
" nnoremap <silent> <C-c> :w \| :call CloseErrorWindows() \| :Neomake <cr>
nnoremap <silent> <C-c> :call WriteAndLint() <cr>

" In normal map mode, press Ctrl-Z to close Syntastic error window
nnoremap <silent> <C-z> :call CloseErrorWindows() <cr>

" For whatever reason, the ColorScheme event doesn't fire anymore?.
augroup neomake_scheme
    au!
    autocmd BufWinEnter *
        \ hi link NeomakeError Error |
        \ hi link NeomakeWarning Todo |
        \ hi link NeomakeInfo Statement |
        \ hi link NeomakeMessage Todo
augroup END

let g:neomake_open_list = 2 " Preserve cursor location on loc-list open
let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeError'}
let g:neomake_warning_sign = {
     \   'text': '⚠',
     \   'texthl': 'NeomakeWarning',
     \ }
let g:neomake_message_sign = {
      \   'text': '➤',
      \   'texthl': 'NeomakeMessage',
      \ }
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfo'}

" **** GCC Syntax Checker ****
let g:neomake_cpp_gcc_maker = {
    \ 'exe': 'g++',
    \ 'args': [
        \ '-fsyntax-only',
        \ '-Wall',
        \ '-Werror',
        \ '-pedantic',
        \ '-O1',
        \ '--std=c++11',
        \ '-I.',
        \ '-I..'
    \ ],
\ }
let g:neomake_cpp_enabled_makers = ['gcc']

" **** bash Syntax Checker ****
" Redefined to remove -x flag, which causes errors.
let g:neomake_sh_shellcheck_maker = {
    \ 'append_file'     : 1,
    \ 'args'            : ['-fgcc'],
    \ 'auto_enabled'    : 1,
    \ 'cwd'             : '%:h',
    \ 'errorformat'     : '%f:%l:%c: %trror: %m [SC%n],%f:%l:%c: %tarning: %m [SC%n],%I%f:%l:%c: Note: %m [SC%n] ',
    \ 'exe'             : 'shellcheck',
    \ 'output_stream'   : 'stdout',
    \ 'short_name'      : 'SC',
\ }

" **** TeX Syntax Checker ****

" -c:   clean regeneratable files
" -cd:  change-dir to the source file before processing
" -f:   continue processing after errors
" -g:   force reprocessing, even if no changes were made
" -pvc: preview file continuously
let g:neomake_tex_latexmk_maker = {
    \ 'exe' : 'latexmk',
    \ 'args' : [
    \   '-c',
    \   '-cd',
    \   '-f',
    \   '-g',
    \   '-pdf',
    \   '-pvc',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \ ],
\ }



"=============================================================================
"   NerdTree                                                [NERDTREE]
"=============================================================================
" Open NerdTree automatically if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NerdTree if you do vim <dir>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close NerdTree if it's the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NerdTree with CTRL-N
noremap <silent> <C-n> :NERDTreeToggle<cr>

let NERDTreeQuitOnOpen = 1

"=============================================================================
"   Tagbar                                                  [TAGBAR]
"=============================================================================
" Open an informational bar showing ctags for the current file.
" Will open Tagbar, jump to it, and close after choosing a tag.
nnoremap <silent> <Leader>g :TagbarOpenAutoClose<cr>
nnoremap <silent> <Leader>b :TagbarToggle<cr>

"=============================================================================
"   nvim-completion-manager                                 [NCM]
"=============================================================================
if has('nvim')
    " Insert mode tab-completion without breaking real presses of the tab key.
    inoremap <expr><tab> pumvisible() ? "\<C-y>" : "\<tab>"

    " Press Enter to close the menu **and also** start a new line.
    inoremap <expr> <cr> pumvisible() ? "\<C-e>\<cr>" : "\<cr>"

    " Enable vimtex support.
    augroup nvim_cm_setup
      autocmd!
      autocmd User CmSetup call cm#register_source({
            \ 'name' : 'vimtex',
            \ 'priority': 8,
            \ 'scoping': 1,
            \ 'scopes': ['tex'],
            \ 'abbreviation': 'tex',
            \ 'cm_refresh_patterns': g:vimtex#re#ncm,
            \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
            \ })
    augroup END
endif

"=============================================================================
"   vim-easytags                                            [EASYTAGS]
"=============================================================================

" General Settings
    let g:easytags_file = '~/.tags'     " Store tags in the home directory.
    let g:easytags_auto_highlight = 0   " Disable tag highlighting.

" Performance Settings
    let g:easytags_async = 1            " Generate tags asynchronously.
    "let g:easytags_python_enabled = 1   " Use faster Python syntax highlighter.

"   With this setup, it's actually a bad idea to turn this option on.
"       I ran :UpdateTags inside of /usr, and the tags file it generated was
"   over a gibibyte (GiB) in size.
"       It's probably okay to turn this on in a local .vimrc, especially
"   with asynchronous execution, but if you turn it on globally, you run
"   the risk of making your global tags file unusably large.
"
" let g:easytags_autorecurse = 1      " Generate tags for all subdirs as well.

" Recursively generate tags for the current file, and everything in
"   subdirectories below.
nnoremap <silent> <Leader>tu :UpdateGlobalTags<cr>

" Update Frequency

    "let g:easytags_on_cursorhold = 1    " Run :UpdateTags whenever idle.

    " Try to trigger this all the time. Wasteful multithreading HO!
    "let g:easytags_always_enabled = 1   " HA HA HA HA HAAAAAAAA
    let g:easytags_events = [
        \ 'BufWritePost',
        \ 'BufEnter',
        \ 'BufLeave'
    \ ]

"=============================================================================
"   vimtex                                                  [VIMTEX]
"=============================================================================
" Enable folding of documents by LaTeX structure.
let g:vimtex_fold_enabled=1


"=============================================================================
"   UltiSnips                                               [ULTISNIPS]
"=============================================================================
" Decide whether to open snippet editor in a horizontal/vertical split
" automatically.
let g:UltiSnipsEditSplit='context'

" Append the UltiSnips directory in the ~/vimrc folder to runtimepath.
let &runtimepath.=',~/vimrc/'

" Store snippets files in the vimrc repository.
let g:UltiSnipsSnippetsDir='~/vimrc/UltiSnips'

" Search the above directory for snippets files.
let g:UltiSnipsSnippetDirectories=["UltiSnips", "~/vimrc/UltiSnips"]

let g:UltiSnipsExpandTrigger='<Leader><Tab>'
let g:UltiSnipsListSnippets='<Leader>ui'
let g:UltiSnipsJumpForwardTrigger='<Leader><Tab>'
let g:UltiSnipsJumpBackwardTrigger='<Leader><S-Tab>'

" Launch UltiSnips snippets editor.
"   'The UltiSnipsEdit command opens a private snippet definition file for the
"   current filetype. If no snippet file exists, a new file is created.'
nnoremap <silent> <Leader>ue :UltiSnipsEdit<cr>


"=============================================================================
"   LanguageClient-neovim                                   [LSP]
"=============================================================================
" Debugging Notes
" https://github.com/autozimu/LanguageClient-neovim/issues/72
"
" TROUBLESHOOTING: If the cquery LSP doesn't work, try the following:
" 1) Verify that `~/.local/stow/cquery/bin/cquery --language-server` runs.
" 2) Verify that `~/.config/nvim/settings.json` is correctly populated.
" 3) Verify that nvim has registered all active remote plugins. (:CheckHealth,
"    :UpdateRemotePlugins).
" 4) Make sure that the active directory contains `compile_commands.json`.

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Load LanguageClient settings.json files when relevant.
" This must be an absolute path; tilde expansion doesn't work.
"let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
let g:LanguageClient_settingsPath = '/home/yiliny/.config/nvim/settings.json'
let g:LanguageClient_loadSettings = 1

" NOTE: cquery requires that `compile_commands.json` exist in the current
"       directory or a parent directory!
"
"       Running `bear make` on a Makefile-based project will allow bear
"       to capture the compilation commands used and generate a matching
"       JSON file. If `compile_commands.json` is empty, try running
"       `make clean` first.
"
"       (Obviously, this only works if you have bear installed.)
let s:cqueryArgsList = [
    \ '~/.local/stow/cquery/bin/cquery',
    \ '--language-server',
    \ '--log-stdin-stdout-to-stderr'
\]
" let g:LanguageClient_serverCommands = {
"     \ 'cpp': s:cqueryArgsList,
"     \ 'cpp.doxygen': s:cqueryArgsList,
"     \ 'python': ['pyls']
"     \ }
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['clangd'],
    \ 'cpp.doxygen': ['clangd'],
    \ 'python': ['pyls']
    \ }

" Show type info and short doc of identifier under cursor.
nnoremap <silent> <Leader>s :call LanguageClient_textDocument_hover()<cr>

" Goto definition of identifier.
nnoremap <silent> <Leader>t :call LanguageClient_textDocument_definition()<cr>

" Rename the identifier under the cursor.
" NOTE: requires `set hidden`
nnoremap <silent> <Leader>pr :call LanguageClient_textDocument_rename()<cr>

" List the symbols in the current document.
nnoremap <silent> <Leader>ps :call LanguageClient_textDocument_documentSymbol()<cr>

" List all references of the identifier under the cursor.
nnoremap <silent> <Leader>pf :call LanguageClient_textDocument_references()<cr>

"=============================================================================
"   BufExplorer                                             [BUFFER]
"=============================================================================
" Don't go to the active window after opening a buffer.
let g:bufExplorerFindActive=0

" Easier shortcut for toggling bufexplorer.
nnoremap <silent> <Leader>bb :ToggleBufExplorer<cr>

"=============================================================================
"   vim-repeat                                              [REPEAT]
"=============================================================================
" Ctrl-S to make vim-obsession start saving the current session in the current
" directory.
nnoremap <silent> <C-s> :Obsession .<cr>

" Ctrl-P to pause/resume vim-obsession.
nnoremap <silent> <C-p> :Obsession<cr>

"=============================================================================
"   vim-easymotion                                          [EASYMOTION]
"=============================================================================
" Easymotion prefix/leader key.
map <Bslash> <Plug>(easymotion-prefix)

" Less case-sensitive easymotion jumping.
let g:EasyMotion_smartcase = 1

"=============================================================================
"   vim-commentary                                          [COMMENTARY]
"=============================================================================
" Easier keymappings that use <Leader> instead of 'g'.
nmap <Leader>c gc
vnoremap <silent> <Leader>c :Commentary<cr>

"=============================================================================
"   tabular                                                 [TABULAR]
"=============================================================================
" Faster mapping to access Tabular Ex command.
nnoremap t :Tabularize /
vnoremap t :Tabularize /

nnoremap <silent> tt :Tabularize /,<cr>
vnoremap <silent> tt :Tabularize /,<cr>

"=============================================================================
"   vim-lexical                                             [LEXICAL]
"=============================================================================

let g:lexical#spellfile = ['~/.local/share/nvim/site/spell/en.utf-8.add',]
let g:lexical#dictionary = ['~/vimrc/dictionary/english.dict',]
let g:lexical#thesaurus = ['~/vimrc/thesaurus/mthesaur.txt',]

" EFFECTS:  Enables vim-lexical's spellchecking and thesaurus functionality.
"           Adds spellcheck to the list of autocompletion options.
function! EnableLexical()
    call lexical#init({'spell': 1,})
endfunction

"=============================================================================
"   vim-easy-align                                          [EASYALIGN]
"=============================================================================
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-----------------------------------------------------------------------------
" Alignment:    after entering EasyAlign, use Enter to cycle through left,
"               right, and center alignment options.
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" Examples:
"--------------------+------------------------------------+--------------------
"  With visual map   | Description                        | Equivalent command
"--------------------+------------------------------------+--------------------
"  <Enter><Space>    | Around 1st whitespaces             | :'<,'>EasyAlign\
"  <Enter>2<Space>   | Around 2nd whitespaces             | :'<,'>EasyAlign2\
"  <Enter>-<Space>   | Around the last whitespaces        | :'<,'>EasyAlign-\
"  <Enter>-2<Space>  | Around the 2nd to last whitespaces | :'<,'>EasyAlign-2\
"  <Enter>:          | Around 1st colon ( `key:  value` ) | :'<,'>EasyAlign:
"  <Enter><Right>:   | Around 1st colon ( `key : value` ) | :'<,'>EasyAlign:<l1
"  <Enter>=          | Around 1st operators with =        | :'<,'>EasyAlign=
"  <Enter>3=         | Around 3rd operators with =        | :'<,'>EasyAlign3=
"  <Enter>*=         | Around all operators with =        | :'<,'>EasyAlign*=
"  <Enter>**=        | Left-right alternating around =    | :'<,'>EasyAlign**=
"  <Enter><Enter>=   | Right alignment around 1st =       | :'<,'>EasyAlign!=
"  <Enter><Enter>**= | Right-left alternating around =    | :'<,'>EasyAlign!**=
"--------------------+------------------------------------+--------------------
" NOTE: Preceding the delimiter with a number X means "align around every Xth
"       delimiter". Preceding the delimiter with a single `*` means "align
"       around every occurrence of the delimiter." Two stars alternates
"       between left-right alignment after each delimiter.
"
"       By default, EasyAlign will align around the first occurrence of the
"       delimiter.
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" Indentation Option Settings:
"-----------------------------------------------------------------------------
"       k       |       'keep'      |       Preserve existing indentation.
"-----------------------------------------------------------------------------
"       d       |       'deep'      |       Use the indentation of the
"               |                   |       most indented line.
"-----------------------------------------------------------------------------
"       s       |       'shallow'   |       Use the indentation of the
"               |                   |       least indented line.
"-----------------------------------------------------------------------------
"       n       |       'none'      |       Left-align in-and-along the
"               |                   |       left boundary of selected text.
"-----------------------------------------------------------------------------
let g:easy_align_indentation = "s"

" Visual Block select all text between the next matched pair of parentheses.
nnoremap gf /(<CR>l<C-v>/)<CR>

"=============================================================================
"   ReplaceWithRegister                                     [REPLACEREGISTER]
"=============================================================================
" Unmap and replace the default ReplaceWithRegister commands.
xmap <leader>r  <Plug>ReplaceWithRegisterVisual
nmap <leader>rr <Plug>ReplaceWithRegisterLine
nmap <leader>r  <Plug>ReplaceWithRegisterOperator
