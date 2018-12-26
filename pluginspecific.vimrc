scriptencoding utf-8
"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"
"   localvimrc                                              [LOCALVIMRC]
"   Asynchronous Lint Engine                                [ALE]
"   NerdTree                                                [NERDTREE]
"   Tagbar                                                  [TAGBAR]
"   vim-easytags                                            [EASYTAGS]
"   vimtex                                                  [VIMTEX]
"   UltiSnips                                               [ULTISNIPS]
"   coc.nvim                                                [COC]
"   BufExplorer                                             [BUFFER]
"   vim-repeat                                              [REPEAT]
"   vim-easymotion                                          [EASYMOTION]
"   vim-commentary                                          [COMMENTARY]
"   tabular                                                 [TABULAR]
"   vim-lexical                                             [LEXICAL]
"   vim-easy-align                                          [EASYALIGN]
"   ReplaceWithRegister                                     [REPLACEREGISTER]
"   ConqueGDB                                               [CONQUEGDB]
"   fuzzy-find vim plugin                                   [FZFVIM]
"   vim-airline                                             [AIRLINE]
"   vim-pencil                                              [PENCIL]
"   vim-wordy                                               [WORDY]
"   vimwiki                                                 [VIMWIKI]
"   diffconflicts                                           [DIFFCONFLICTS]
"   winresizer                                              [WINRESIZER]
"   vim-signify                                             [SIGNIFY]
"   quick-scope                                             [QUICKSCOPE]
"   vim-markbar                                             [MARKBAR]
"   vim-illuminate                                          [ILLUMINATE]
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
hi ALEWarning cterm=underline ctermfg=164

let g:ale_sign_error = 'X>'
let g:ale_sign_warning = 'W>'
let g:ale_sign_info = 'I>'
let g:ale_sign_style_error = 'SX'
let g:ale_sign_style_warning = 'S>'

let g:ale_cpp_gcc_options = '--std=c++17 -Wall -Werror -Wextra -pedantic -O3 -DDEBUG -I. -I..'

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0

"=============================================================================
"   NerdTree                                                [NERDTREE]
"=============================================================================
augroup NERDTree
    au!
    " Open NerdTree automatically if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    " Open NerdTree if you do `vim <DIR>`
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

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
"   Tagbar                                                  [TAGBAR]
"=============================================================================
" Open an informational bar showing ctags for the current file.
" Will open Tagbar, jump to it, and close after choosing a tag.
nnoremap <silent> <Leader>g :TagbarOpenAutoClose<cr>
nnoremap <silent> <Leader>b :TagbarToggle<cr>

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
let g:UltiSnipsSnippetDirectories=['UltiSnips', '~/vimrc/UltiSnips']

let g:UltiSnipsExpandTrigger='<Leader><Tab>'
let g:UltiSnipsListSnippets='<Leader>ui'
let g:UltiSnipsJumpForwardTrigger='<Leader><Tab>'
let g:UltiSnipsJumpBackwardTrigger='<Leader><S-Tab>'

" Launch UltiSnips snippets editor.
"   'The UltiSnipsEdit command opens a private snippet definition file for the
"   current filetype. If no snippet file exists, a new file is created.'
nnoremap <silent> <Leader>ue :UltiSnipsEdit<cr>

" UltiSnips slows neovim down substantially, due to performance issues caused
" by neovim's emulation of vim's Python API. This isn't noticeable on a native
" Ubuntu installation, but it's a major annoyance on WSL.
"
" These performance problems are caused by the UltiSnips_AutoTrigger augroup,
" as described here:
"   https://github.com/SirVer/ultisnips/issues/593#issuecomment-151101506
"
" Since I don't use AutoTrigger snippets, I disable that augroup here.
augroup UltiSnips_AutoTrigger
    au!
augroup end

"=============================================================================
"   coc.nvim                                                [COC]
"=============================================================================
" Insert mode tab-completion without breaking real presses of the tab key.
inoremap <expr><tab> pumvisible() ? "\<C-y>" : "\<tab>"

" Press Enter to close the menu **and also** start a new line.
inoremap <expr> <cr> pumvisible() ? "\<C-e>\<cr>" : "\<cr>"

" Suppress annoying completion menu messages.
set shortmess+=c

" Hop between snippet placeholders!
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" CodeLens!
nmap <leader>pc <Plug>(coc-codelens-action)

" Rename symbol.
nmap <leader>pr <Plug>(coc-rename)

" Jump between problems.
nmap <leader>n <Plug>(coc-diagnostic-next)
nmap <leader>N <Plug>(coc-diagnostic-prev)

" Jump to...
nmap <leader>t  <Plug>(coc-definition)
nmap <leader>td <Plug>(coc-type-definition)
nmap <leader>ti <Plug>(coc-implementation)
nmap <leader>sr <Plug>(coc-references)

" Autoformat!
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>f  <Plug>(coc-format-selected)

" Display diagnostics in airline.
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

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
let g:easy_align_indentation = 's'

" Visual Block select all text between the next matched pair of parentheses.
nnoremap gf /(<CR>l<C-v>/)<CR>

"=============================================================================
"   ReplaceWithRegister                                     [REPLACEREGISTER]
"=============================================================================
" Unmap and replace the default ReplaceWithRegister commands.
xmap <leader>r  <Plug>ReplaceWithRegisterVisual
nmap <leader>rr <Plug>ReplaceWithRegisterLine
nmap <leader>r  <Plug>ReplaceWithRegisterOperator

"=============================================================================
"   ConqueGDB                                               [CONQUEGDB]
"=============================================================================

" Continue updating Conque buffers after switching to another buffer.
let g:ConqueTerm_ReadUnfocused = 1

" Try to use the Python3 interface, which I presume is better?
let g:ConqueTerm_PyVersion = 3

" Open the GDB terminal on the right side of the screen.
let g:ConqueGdb_SrcSplit = 'left' " Open source on the *left* side.

" Update very frequently while I'm in insert mode.
let g:ConqueTerm_FocusedUpdateTime = 100

" Update very frequently while I'm not in insert mode.
let g:ConqueTerm_UnfocusedUpdateTime = 100

" Disable start warnings.
let g:ConqueTerm_StartMessages = 0

"=============================================================================
"   fuzzy-find vim plugin                                   [FZFVIM]
"=============================================================================

fu! FuzzyFindPrefix()
    return 'm'
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
"   vim-airline                                             [AIRLINE]
"=============================================================================

" Colorful and visually distinct, but in a tasteful way.
let g:airline_theme='wombat'

set noshowmode " Disable vim's built-in modeline.

" Use vertical bar separators in the statusline.
let g:airline_left_set='|'
let g:airline_right_set='|'

" The helpdocs claim that this makes airline faster.
let g:airline_highlighting_cache = 1

" Don't scan runtimepath for airline-compatible plugins on startup.
let g:airline#extensions#disable_rtp_load = 1

" Load vim-fugitive, and a markdown wordcounter, but nothing else.
let g:airline_extensions = ['branch', 'wordcount']

" Trim some gunk from the rightmost part of the statusline.
let g:airline_section_x = '%{airline#util#wrap(airline#parts#filetype(),0)}% '
let g:airline_section_z = '%{airline#util#wrap(airline#extensions#obsession#get_status(),0)}%3p%% l:%4l%#__restore__#%#__accent_bold#/%L c:%3v'

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
"   <Leader>wd                  Delete current wiki page.
"       :VimwikiDeleteLink          // ditto
"   <Leader>wr                  Rename current wiki page.
"       :VimwikiRenameLink          // ditto
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

let g:vimwiki_folding = 1       " Enable content-aware folding.
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

let g:markbar_marks_to_display = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:markbar_section_separation = 0

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
