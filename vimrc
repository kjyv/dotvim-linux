set tabstop=2
set shiftwidth=2
set expandtab

set nocompatible
filetype plugin on
"set modeline
"set modelines=1
set breakindent   " (needs vim >= 7.4.338)

" show all whitespace (needs vim >= 7.4.710)
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set list

" searching
set incsearch
set ignorecase
set smartcase
set number

" pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

" airline
set laststatus=2
let g:airline_powerline_fonts = 1
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" cmds tab completion
set wildmode=longest,list,full
set wildmenu

" code tab completion (supertab+jedi)
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionTypeDiscovery = [
      \ "&omnifunc:<c-x><c-o>",
      \ "&completefunc:<c-x><c-u>",
      \ ]
let g:SuperTabLongestHighlight = 1
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 1
autocmd FileType python set omnifunc=pythoncomplete#Complete

" crtlp
let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rc'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" gui tabs
source $HOME/.vim/tabs.vim
noremap <c-tab> :tabnext<cr>
noremap <c-s-tab> :tabprev<cr>
nnoremap <C-w> :conf q<CR>
inoremap <C-w> <Esc>:conf q<CR>

" others
source $HOME/.vim/stripWhitespace.vim
