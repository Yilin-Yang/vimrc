"=============================================================================
"                             TABLE OF CONTENTS
"=============================================================================
"
"   C++ Formatting                                          [CPP]
"   Markdown Formatting                                     [MARKDOWN]
"=============================================================================

"=============================================================================
"   C++ Formatting                                          [CPP]
"=============================================================================

" Set C++ specific formatting options.
function CppFormat()
    set colorcolumn=81              " My personal line limit
    set filetype=cpp.doxygen        " And highlight doxygen formatting
endfunction

" C++ Formatting
" .cpp files
 augroup cpp_format
    au!
    autocmd BufEnter,BufNew *.cpp       call CppFormat()
    autocmd BufEnter,BufNew *.hpp       call CppFormat()
 augroup end


"=============================================================================
"   Markdown Formatting                                     [MARKDOWN]
"=============================================================================

" Set Markdown specific formatting options.
function MdFormat(should_format)
    call TextWrap(a:should_format)
endfunction

" Markdown Formatting
" .md files, .markdown files
 augroup md_format
    au!
    autocmd BufEnter,BufNew *.md        call MdFormat(1)
    autocmd BufEnter,BufNew *.markdown  call MdFormat(1)
    autocmd BufLeave *.md               call MdFormat(0)
    autocmd BufLeave *.markdown         call MdFormat(0)
 augroup end
