
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab

"vim modeline are insecure, but can be useful
"set modeline
"set modelines=1

set tw=100  "line break width, use gqgq to break lines automatically
set wrap nolist
set formatoptions=croql "tcq

"always use black hole register
"http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text
xnoremap p "_dP
