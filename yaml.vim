" vim: ts=4 sw=4 et

function! neomake#makers#ft#yaml#EnabledMakers() abort
    return ['yamllint']
endfunction

function! neomake#makers#ft#yaml#yamllint() abort
    return {
        \ 'args': ['-f', 'parsable', '-c', '~/maav/.yamllint'],
        \ 'errorformat': '%E%f:%l:%c: [error] %m,%W%f:%l:%c: [warning] %m',
        \ }
endfunction
