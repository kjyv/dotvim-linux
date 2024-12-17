
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set hlsearch
set incsearch
set smarttab

"vim modeline are insecure, but can be useful
"set modeline
"set modelines=1

set tw=100  "line break width, use gqgq to break lines automatically
set wrap nolist
set formatoptions=croql "tcq

"always use black hole register to delete (cut and paste still as normal)
"http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text

noremap d "_d
noremap dd "_dd
noremap D "_D

" paste without yanking
vnoremap p "_dP

set backspace=2

" center the screen after jumping
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap # #zzzv
nnoremap * *zzzv

" center after half screen jump
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

