if exists('*ColorColumnBlock') | call ColorColumnBlock(81) | endif
noremap <buffer> <silent> <leader>e :call CenterTextAndPad('/')<cr>
call CPPIndent()
if exists(':ALEDisable')
    ALEDisable
endif
