runtime colors/default.vim  " use default colorscheme as base
let g:colors_name = 'yilin'
"=============================================================================
"   Highlighting                                            [HIGHLIGHTING]
"=============================================================================
" Further information on highlight groups and highlight color values
" can be found through:
"   :help highlight-groups
"   :help gui-colors
"   https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
"=============================================================================

hi CursorColumn cterm=bold ctermbg=NONE ctermfg=white guibg=NONE guifg=white
              " ^ bold every character that's in the same column as the cursor

" Less obtrusive `listchars`.
hi SpecialKey ctermbg=NONE ctermfg=darkgray guibg=bg guifg=darkgray

hi clear Whitespace
hi link Whitespace SpecialKey
hi clear NonText
hi link NonText SpecialKey

" brighter magenta to override dark fuchsia of my terminal colorscheme, which
" is hard to read against my terminal background
hi Constant ctermfg=201

" Use a dark pop-up menu background for readable language server errors
hi clear Pmenu
hi Pmenu ctermbg=17 ctermfg=15
hi clear PmenuSel
hi PmenuSel ctermbg=18 ctermfg=45 cterm=bold,underline
hi PmenuSbar ctermbg=236

if exists('&pumblend')
  set pumblend=1
endif

" Distinguish the TermCursor from matched parentheses.
hi clear MatchParen
hi MatchParen cterm=bold,underline

" Less obtrusive spellchecker markings.
hi SpellBad cterm=underline ctermfg=DarkRed ctermbg=NONE

" As with steak, rare words are _better._
" (Also, can't find an option to turn off rare word spellchecking.)
hi clear SpellRare

" Capitalization warnings trigger on the word `vim,` which makes me sad.
set spellcapcheck=

" Less obtrusive vertical splits.
hi clear VertSplit
hi link VertSplit Delimiter

" Disable ugly gray background in visual selections.
hi Visual cterm=reverse

" Make folds less visually distracting, but still visually distinct.
hi clear Folded
hi Folded ctermfg=81 guifg=#ff80ff

" Disable ugly gray background in side columns.
hi FoldColumn ctermbg=NONE
hi SignColumn ctermbg=NONE

" Make the tabline a bit more minimal.
hi TabLine ctermbg=NONE ctermfg=darkgray
hi TabLineFill cterm=NONE ctermbg=235
hi TabLineSel ctermfg=224

" Make the statusline a bit more minimal.
" NOTE: these are effectively disabled by vim-airline.
hi StatusLine cterm=bold,underline ctermfg=224
hi StatusLineNC cterm=underline ctermfg=224

" Darken backgrounds beyond my personal line limit.
hi ColorColumn ctermbg=235 guibg=DarkGray

" Better color contrast in vimdiffs, with my wonky terminal colorschemes.
" " dark red background in difftext
hi DiffText ctermbg=1

" ditto, for error messages
hi clear Error
hi link Error ErrorMsg

" ditto, for spelling warnings
hi SpellLocal ctermbg=23
hi SpellCap ctermbg=21
