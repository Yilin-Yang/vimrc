scriptencoding utf-8
"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   localvimrc                                              [LOCALVIMRC]
"   Asynchronous Lint Engine                                [ALE]
"   NerdTree                                                [NERDTREE]
"   vimtex                                                  [VIMTEX]
"   nvim-lspconfig                                          [LSP]
"   BufExplorer                                             [BUFFER]
"   vim-easymotion                                          [EASYMOTION]
"   vim-commentary                                          [COMMENTARY]
"   tabular                                                 [TABULAR]
"   vim-lexical                                             [LEXICAL]
"   vim-easy-align                                          [EASYALIGN]
"   ReplaceWithRegister                                     [REPLACEREGISTER]
"   fuzzy-find vim plugin                                   [FZFVIM]
"   lightline.vim                                           [LIGHTLINE]
"   vim-pencil                                              [PENCIL]
"   vim-wordy                                               [WORDY]
"   vimwiki                                                 [VIMWIKI]
"   diffconflicts                                           [DIFFCONFLICTS]
"   winresizer                                              [WINRESIZER]
"   vim-signify                                             [SIGNIFY]
"   quick-scope                                             [QUICKSCOPE]
"   vim-markbar                                             [MARKBAR]
"   vim-illuminate                                          [ILLUMINATE]
"   vim-syncopate                                           [SYNCOPATE]
"   coq_nvim                                                [COMPLETION]
"=============================================================================


"=============================================================================
"   localvimrc                                              [LOCALVIMRC]
"=============================================================================
let g:localvimrc_ask=0
let g:localvimrc_sandbox=0
let g:localvimrc_name=['.yvimrc', '.lvimrc']

"=============================================================================
"   Asynchronous Lint Engine                                [ALE]
"=============================================================================
hi ALEWarning cterm=underline

hi clear ALEErrorSign
hi clear ALEInfoSign
hi clear ALEStyleErrorSign
hi clear ALEWarningSign

hi ALEErrorSign ctermfg=9
hi ALEInfoSign ctermfg=12
hi ALEStyleErrorSign ctermfg=14
hi ALEWarningSign ctermfg=11

hi clear ALEError
hi ALEError cterm=underline

let g:ale_linter_aliases = {
  \ 'vader': 'vim',
\ }

if !exists('g:ale_linters') | let g:ale_linters = {} | endif
let g:ale_linters.python = ['mypy', 'pycodestyle', 'pylint']

let g:ale_sign_error = 'X>'
let g:ale_sign_warning = 'W>'
let g:ale_sign_info = 'I>'
let g:ale_sign_style_error = 'SX'
let g:ale_sign_style_warning = 'S>'

let g:ale_cpp_gcc_options = '--std=c++17 -Wall -Werror -Wextra -pedantic -O3 -DDEBUG -I. -I..'

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1

let g:ale_python_auto_pipenv = 1

" to fix the slowneses caused by calls to executable() inside of
" ale#engine#IsExecutable().
let g:ale_cache_executable_check_failures = 1

"=============================================================================
"   NerdTree                                                [NERDTREE]
"=============================================================================
augroup NERDTree
    au!
    " Open NerdTree automatically if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    if !exists('g:gui_oni')
      autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    endif

    " Open NerdTree if you do `vim <DIR>`
    autocmd StdinReadPre * let s:std_in=1
    if !exists('g:gui_oni')
      autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    endif

    " Close NerdTree if it's the only window open.
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup end

" Open NerdTree with CTRL-N
noremap <silent> <C-n> :NERDTreeToggle<cr>

" Close NerdTree after opening a file from the sidebar.
let g:NERDTreeQuitOnOpen=1

" Don't change the PWD from the NerdTree sidebar.
let g:NERDTreeChDirMode=0

"=============================================================================
"   vimtex                                                  [VIMTEX]
"=============================================================================
" Enable folding of documents by LaTeX structure.
let g:vimtex_fold_enabled=1

" Disable opening the quickfix window during continuous compilation.
let g:vimtex_quickfix_enabled=0

" Stop error messages on startup.
let g:tex_flavor = 'latex'

"=============================================================================
"   nvim-lspconfig                                          [LSP]
"=============================================================================
" Register Lua setup code.
if has('nvim')
    lua require'lsp'
endif


" Shift-Tab to manually trigger popup menu.
inoremap <S-Tab> <C-x><C-u>

" Show hover information for the given symbol.
nnoremap <leader>h <cmd>lua vim.lsp.buf.hover()<CR>

" Show signature help.
nnoremap <leader>hs <cmd>lua vim.lsp.buf.signature_help()<CR>

" Show code actions for the current symbol.
nnoremap <leader>ta <cmd>lua vim.lsp.buf.code_action()<CR>

" Rename symbol.
nnoremap <leader>pr <cmd>lua vim.lsp.buf.rename()<CR>

" Jump to...
nnoremap <leader>t  <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>td <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ttd <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>ti <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>sr <cmd>lua vim.lsp.buf.references()<CR>

" Autoformat!
" nmap <leader>f  <cmd>lua vim.lsp.buf.range_formatting()<CR>
" xmap <leader>f  <cmd>lua vim.lsp.buf.range_formatting()<CR>

"=============================================================================
"   BufExplorer                                             [BUFFER]
"=============================================================================
" Don't go to the active window after opening a buffer.
let g:bufExplorerFindActive=0

" Easier shortcut for toggling bufexplorer.
nnoremap <silent> <Leader>bb :ToggleBufExplorer<cr>

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
xnoremap <silent> <Leader>c :Commentary<cr>

"=============================================================================
"   tabular                                                 [TABULAR]
"=============================================================================
" Faster mapping to access Tabular Ex command.
xnoremap <leader>t :Tabularize /

xnoremap <silent> <leader>tt :Tabularize /,<cr>

"=============================================================================
"   vim-lexical                                             [LEXICAL]
"=============================================================================

let g:lexical#spellfile = [&spellfile]
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
xmap <Enter> <Plug>(EasyAlign)

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
let g:easy_align_indentation = 's'

"=============================================================================
"   ReplaceWithRegister                                     [REPLACEREGISTER]
"=============================================================================
" Unmap and replace the default ReplaceWithRegister commands.
xmap <leader>r  <Plug>ReplaceWithRegisterVisual
nmap <leader>rr <Plug>ReplaceWithRegisterLine
nmap <leader>r  <Plug>ReplaceWithRegisterOperator

"=============================================================================
"   fuzzy-find vim plugin                                   [FZFVIM]
"=============================================================================

fu! FuzzyFindPrefix()
    return 'ff'
endf

" fzf files in the PWD.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'ff'  . ' :Files .<cr>'

" Start writing a 'fuzzyfind file' command.
execute 'nnoremap '          . FuzzyFindPrefix() . 'f'   . ' :Files '

" fzf through 'git ls files'.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'gf'  . ' :GFiles<cr>'

" Start writing a 'git ls files' fuzzyfind command.
execute 'nnoremap '          . FuzzyFindPrefix() . 'gl'  . ' :GFiles '

" fzf through 'git status'.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'gs'  . ' :GFiles?<cr>'

" fzf through git commits. Requires fugitive.vim.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'gc'  . ' :Commits<cr>'

" fzf through git commits for the active buffer.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'gb'  . ' :BCommits<cr>'

" fzf through vim marks.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'm'  . ' :Marks<cr>'

" fzf through vim keymappings.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'p'  . ' :Maps<cr>'

" fzf through vim commands.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'd'  . ' :Commands<cr>'

" fzf through lines in all loaded buffers.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'l'  . ' :Lines<cr>'

" fzf through lines in the active buffer.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'bl' . ' :BLines<cr>'

" fzf through active windows.
execute 'nnoremap <silent> ' . FuzzyFindPrefix() . 'w'  . ' :Windows<cr>'

"=============================================================================
"   lightline.vim                                           [LIGHTLINE]
"=============================================================================
call extend(g:lightline, {
  \ 'enable': {
  \   'statusline': 1,
  \   'tabline': 0,
  \   },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'wordcount', 'fileformat', 'fileencoding', 'filetype'] ],
  \ },
  \ 'component': {
  \   'charvaluehex': '0x%B',
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#Head',
  \   'wordcount': 'GetWordcount',
  \ },
  \ })

function! GetWordcount() abort
  let l:wc_dict = wordcount()
  let l:ft = &filetype
  if has_key(g:wordcount_enabled_fts, &filetype)
    return printf('%d words', l:wc_dict.words)
  else
    return ''
  endif
endfunction
let g:wordcount_enabled_fts = {
    \ 'help': 1,
    \ 'markdown': 1,
    \ 'tex': 1,
    \ 'text': 1,
    \ 'vimwiki': 1,
    \ }

" coc diagnostics in lightline
let g:lightline.component_function.cocstatus = 'coc#status'

set noshowmode " Disable vim's built-in modeline.

"=============================================================================
"   vim-pencil                                              [PENCIL]
"=============================================================================

let g:pencil#autoformat = 0         " disable 'autocorrect', esp. w/ hardwrap
let g:pencil#textwidth = 80         " line width
let g:pencil#joinspaces = 1         " two spaces after periods
let g:pencil#conceallevel = 0       " disable formatting character concealment

augroup pencil
    au!
    autocmd FileType markdown,text  call Prose()
augroup end

"=============================================================================
"   vim-wordy                                               [WORDY]
"=============================================================================

" Cycle through word usage checkers.
nnoremap <leader>wn     :NextWordy<cr>
nnoremap <leader>wp     :PrevWordy<cr>

"=============================================================================
"   vimwiki                                                 [VIMWIKI]
"=============================================================================

"------------------------------------------------------------------------------
" Configured partly using the following link as reference:
"   https://www.dailydrip.com/blog/vimwiki
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" USAGE NOTES:
"   If no [count] is specified, assume a count of one (1), unless otherwise
"   noted.
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
"
"------------------------------------------------------------------------------
" OPENING WIKI:
"   [count]<Leader>ww   OR  <Plug>VimwikiIndex
"       Open the index of the [count]th wiki in g:vimwiki_list.
"
"   [count]<Leader>wt   OR  <Plug>VimwikiTabIndex
"       Open the index of the [count]th wiki in g:vimwiki_list *in a new tab.*
"
"   <Leader>ws          OR  <Plug>VimwikiUISelect
"       List and select available wikis in g:vimwiki_list.
"
"   [count]<Leader>wi   OR  <Plug>VimwikiDiaryIndex
"       Open the diary index of the [count]th wiki in g:vimwiki_list.
"
"   [count]<Leader>w<Leader>w   OR  <Plug>VimwikiMakeDiaryNote
"   [count]<Leader>w<Leader>t   OR  <Plug>VimwikiTabMakeDiaryNote
"       Open a diary wiki-file for the current day in the [count]th wiki in
"       g:vimwiki_list [in a new tab.]
"
"   [count]<Leader>w<Leader>y   OR  <Plug>VimwikiMakeYesterdayDiaryNote
"   [count]<Leader>w<Leader>m   OR  <Plug>VimwikiMakeTomorrowDiaryNote
"
"------------------------------------------------------------------------------
" NAVIGATION:
"   <CR>                        Open or create a wiki link.
"       :VimwikiSplitLink           Open/create a wiki link in a split.
"       :VimwikiVSplitLink          Open/create a wiki link in a vertical split.
"   <Backspace>                 Go back to previous wiki page.
"   <Tab>                       Find next link in current page.
"   <S-Tab>                     Find previous link in the current page.
"
"   DIARY:
"       <C-Up>                  Open the previous day's diary.
"       <C-Down>                Open the next day's diary.
"
"------------------------------------------------------------------------------
" PAGE EDITING:
"
"   (these mappings have been disabled in ftplugin/vimwiki.vim)
"   <Leader>wd                  Delete current wiki page.
"       :VimwikiDeleteLink          // ditto
"   <Leader>wr                  Rename current wiki page.
"       :VimwikiRenameLink          // ditto
"   (end notice)
"
"   [[                          Previous header in buffer.
"   ]]                          Next header in buffer.
"   [=                          Previous header with same level as selected.
"   ]=                          Next header with same level as selected.
"   ]u                          Go one header level 'up'.
"   [u                          // ditto
"   +                           Create and/or decorate links.
"
"   LISTS:
"       glr                     Renumber list items.
"       gLr                     Renumber all list items in the current file.
"
"       <C-d>                   (insert mode) Demote current list item.
"       <C-t>                   (insert mode) Promote current list item.
"
"   TABLES:
"       gqq                     Format a table.
"       gww                     // ditto
"       <M-Left>                Move table column left.
"       <M-Right>               Move table column Right.
"
"------------------------------------------------------------------------------
" TEXT OBJECTS:
"   h(eader)
"       ih ('in header')        The text under a header.
"       ah ('around header')    The text under a header, the header itself,
"                                   and trailing whitespace.
"   H(EADER!)
"       iH                      A header's content and all of its subheaders.
"       [count]aH               A header's content and all of its subheaders
"                                   [up to and including the ([count] - 1)th
"                                   generation parent of the current header],
"                                   the header itself, and trailing whitespace.
"   \ (cell in table?)
"
"   c(olumn)
"
"   l(ist item)
"       il                      A list item.
"       al                      A list item AND its children.
"
"------------------------------------------------------------------------------
" LINK FORMATTING:
"   By default, links are specified with respect to the present working
"   directory, similar to directory navigation in a bash terminal.
"   - The '/' prefix (as in '/index') means 'relative to the wiki root.'
"   - The '../' prefix (as in '../index') means 'relative to the parent
"   directory.'
"
"   One can link to diary entries with the following scheme:
"       [[diary:2012-03-05]]
"
"   Raw URLs are also supported, e.g.
"       https://github.com/vimwiki/vimwiki.git
"       mailto:billymagic@gmail.com
"
"------------------------------------------------------------------------------
" TEXT ANCHORS:
"   Section headings and tags can be used as text anchors.
"   See `:h vimwiki-anchors`.
"
"------------------------------------------------------------------------------
" MISCELLANY:
"   - `:VimwikiTOC` creates a table of contents at the top of the current file.
"   - vimwiki has tagbar support!
"------------------------------------------------------------------------------

let g:vimwiki_list = [
    \ {
        \ 'path': '~/notes/',
        \ 'syntax': 'markdown',
        \ 'ext': '.md',
        \ 'index': 'README',
        \ 'auto_toc': 1,
    \ },
\ ]

let g:vimwiki_folding = 'expr'  " Enable content-aware folding.
let g:vimwiki_global_ext = 0    " Disable vimwiki filetype outside of ~/notes.

" Tagbar support.
" Quote from vwtags.py:
"   The value of ctagsargs must be one of 'default', 'markdown' or 'media',
"   whatever syntax you use. However, if you use multiple wikis with different
"   syntaxes, you can, as a workaround, use the value 'all' instead. Then, Tagbar
"   will show markdown style headers as well as default/mediawiki style headers,
"   but there might be erroneously shown headers.
let g:tagbar_type_vimwiki = {
    \ 'ctagstype':  'vimwiki',
    \ 'kinds':      ['h: header'],
    \ 'sro':        '&&&',
    \ 'kind2scope': {'h': 'header'},
    \ 'sort':       0,
    \ 'ctagsbin':   '~/vimrc/misc/vwtags.py',
    \ 'ctagsargs':  'markdown',
\ }

" Shortcut for creating a vimwiki page.
nnoremap <Leader>v :VimwikiGoto \<BS>

" Replace vimwiki's default <Tab> bindings, which break my completion menu.
nmap <Leader>wn <Plug>VimwikiNextLink
nmap <Leader>wp <Plug>VimwikiPrevLink

" Open a link in a vertical split.
nmap <cr>v <Plug>VimwikiVSplitLink

" Open a link in a horizontal split.
nmap <cr>s <Plug>VimwikiSplitLink

"=============================================================================
"   diffconflicts                                           [DIFFCONFLICTS]
"=============================================================================

" Show diffconflicts history, iff vim is running as a diffconflicts mergetool.
nnoremap <expr> <silent> d?
    \ DiffconflictsActive() ?
        \ ":DiffConflictsShowHistory<cr>"
        \ :
        \ ':echoerr "vim is not running as a git mergetool. No history to show."<cr>'

" Write and close multiple active splits.
nnoremap <silent> dq :wall<cr>:qall<cr>

"=============================================================================
"   winresizer                                              [WINRESIZER]
"=============================================================================

" NOTE: `:help ascii` to print the keycode of the key under the cursor
let g:winresizer_keycode_finish = 100 " d

nnoremap <leader>wr :WinResizerStartResize<cr>
nnoremap <leader>wm :WinResizerStartMove<cr>

" unmap winresizer start key
silent! nunmap <C-e>

" Slightly more granular vertical resize control.
let g:winresizer_vert_resize = 5

"=============================================================================
"   vim-signify                                             [SIGNIFY]
"=============================================================================
" Specify the version control systems that I actually use.
let g:signify_vcs_list = [ 'git', 'svn' ]

let g:signify_realtime = 1
" Make sure to disable realtime autowrite on CursorHold and CursorHoldI.
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0

let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change

nnoremap <leader>gt :SignifyToggle<cr>
nnoremap <leader>gf :SignifyFold!<cr>
nnoremap <leader>gd :SignifyDiff<cr>

highlight SignifySignAdd    cterm=bold  ctermbg=none  ctermfg=119
highlight SignifySignDelete cterm=bold  ctermbg=none  ctermfg=167
highlight SignifySignChange cterm=bold  ctermbg=none  ctermfg=227

augroup signify_refresh
    au!
    "autocmd BufEnter   * SignifyRefresh
    "autocmd CursorHold * SignifyRefresh
augroup end

"=============================================================================
"   quick-scope                                             [QUICKSCOPE]
"=============================================================================

" Only activate highlighting after pressing these keys.
let g:qs_highlight_on_keys = ['f', 'F']

augroup quickscope_highlight
    hi clear QuickScopePrimary
    hi clear QuickScopeSecondary

    " Bold and underline, and color in bright purple.
    " Color more brightly for a 'primary' match.
    hi QuickScopePrimary cterm=bold,underline ctermfg=219
    hi QuickScopeSecondary cterm=bold,underline ctermfg=129
augroup end

"=============================================================================
"   vim-markbar                                             [MARKBAR]
"=============================================================================

map <leader>m <Plug>ToggleMarkbar

let g:markbar_marks_to_display = "'\".^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:markbar_peekaboo_marks_to_display = "'\".abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:markbar_section_separation = 0
let g:markbar_explicitly_remap_mark_mappings = v:true

let g:markbar_force_clear_shared_data_on_delmark = v:true

"=============================================================================
"   vim-illuminate                                          [ILLUMINATE]
"=============================================================================

let g:Illuminate_ftblacklist = [
    \ 'nerdtree',
    \ 'markbar',
    \ 'tagbar',
    \ 'help'
\ ]

let g:Illuminate_highlightUnderCursor = 0

hi illuminatedWord cterm=bold,underline gui=bold,underline

"=============================================================================
"   vim-syncopate                                           [SYNCOPATE]
"=============================================================================
" <Leader><   (the following motion, etc.)
" <Leader><>  (to yank the whole buffer, or your selection in visual mode)
Glaive syncopate colorscheme='morning' clear_bg=1

xnoremap <leader><> :call SyncopateExportToClipboard()<cr>

function! SyncopateExportToClipboard() range
  execute a:firstline.','.a:lastline.'SyncopateExportToClipboard'

  " doesn't seem to update Windows clipboard through VcXsrv without this
  " line
  let @+=@+
endfunction

"=============================================================================
"   coq_nvim                                                [COMPLETION]
"=============================================================================
let g:coq_settings = {
    \ 'auto_start': 'shut-up',
    \ 'keymap': {
      \ 'recommended': v:false,
      \ 'jump_to_mark': '',
      \ 'manual_complete': '<C-space>',
    \ }
\ }

" TODO
" https://github.com/ms-jpq/coq_nvim/blob/coq/docs/SNIPS.md#compilation
" :COQsnips compile
function! StartCOQ() abort
    COQsnips compile
    COQnow
endfunction

" pop-up menu mappiings
inoremap <silent><expr> <tab>   pumvisible() ? "\<C-y>" : "\<tab>"
inoremap <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
inoremap <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
inoremap <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
inoremap <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
" ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
