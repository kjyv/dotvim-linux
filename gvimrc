" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
inoremap <c-s> <c-o>:Update<CR>

set guifont=Source\ Code\ Pro\ for\ Powerline\ 10

"gui tabs
source $HOME/.vim/tabs.vim
noremap <c-tab> :tabnext<cr>
noremap <c-s-tab> :tabprev<cr>
nnoremap <C-w> :conf q<CR>
inoremap <C-w> <Esc>:conf q<CR>

