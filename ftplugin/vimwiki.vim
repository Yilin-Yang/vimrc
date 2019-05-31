if exists('g:plugs') && has_key(g:plugs, 'vim-pencil')
    " HardPencil borks some of vimwiki's list-editing commands.
    NoPencil
endif
" Kill vimwiki's default <Tab> bindings, which break my completion menu.
silent! iunmap <buffer> <expr> <Tab>
set syntax=markdown
