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

syntax on
filetype plugin indent on

" pathogen
" execute pathogen#infect()

" Setup vundle and Plugins
let g:vundle_default_git_proto = 'git'
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"
" crtlp
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rc'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" code tab completion (supertab+jedi)
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
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

" cmds tab completion
set wildmode=longest,list,full
set wildmenu

" airline
Plugin 'vim-airline/vim-airline'
set laststatus=2
let g:airline_powerline_fonts = 1
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

"nerdtree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
map <C-n> <plug>NERDTreeTabsToggle<CR>
let g:NERDTreeWinPos = "right"
let NERDTreeMapOpenInTab='<ENTER>'
set switchbuf=useopen,usetab

" gui tabs
source $HOME/.vim/tabs.vim
noremap <c-tab> :tabnext<cr>
noremap <c-s-tab> :tabprev<cr>
nnoremap <C-w> :conf q<CR>
inoremap <C-w> <Esc>:conf q<CR>

" others
source $HOME/.vim/stripWhitespace.vim

" All Plugins must be added before the following line
call vundle#end()
