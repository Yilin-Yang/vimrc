if exists('g:plugs') && has_key(g:plugs, 'vim-pencil')
    " HardPencil borks some of vimwiki's list-editing commands.
    NoPencil
endif
" Kill vimwiki's default <Tab> bindings, which break my completion menu.
silent! iunmap <buffer> <expr> <Tab>
silent! unmap  <buffer> <BS>

" Kill vimwiki's rename window mapping, which conflicts with my winresizer
" mapping.
silent! unmap <buffer> <leader>wr
" silent! unmap <buffer> <leader>wd

set syntax=markdown

if exists(':ALEDisable')
  ALEDisable
endif
