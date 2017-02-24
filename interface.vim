if !has('nvim')
    set encoding=utf-8
endif

if has('gui_macvim')
    set guifont=Monaco\ for\ Powerline:h11
else
    "set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 11
     set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
endif

syntax on
filetype plugin indent on
if has("patch-7.4-399")
  set breakindent   " (needs vim >= 7.4.338)
endif
set hidden

" searching
set incsearch
set ignorecase
set smartcase
set number

" text selection with shift arrow (page jumping is annoying)
imap <S-Up> <Up>
imap <S-Down> <Down>
imap <S-Left> <Left>
imap <S-Right> <Right>
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>

" show some whitespace characters
set list                  " show line-endings, tabs and trailing spaces
set lcs=trail:·,tab:»·    " trailing spaces and tabs are shown but not eol

" show all whitespace (needs vim >= 7.4.710)
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set list

"set mouse mode in terminal
set mouse=v
set guicursor+=a:blinkon0

" jumping to searches with some spacing from top/bottom
" set scrolloff=5

" navigate jumplist with alt-left/-right
"nnoremap <M-Left> <C-O>
"nnoremap <M-Right> <C-i>

" navigate changelist with alt-left/-right
nnoremap <M-Left> g;
nnoremap <M-Right> g,

set showmatch    " show matching braces
set nofoldenable " no folds by default

if has("gui_running")
  " 2 use non backracking regexp engine (faster)
  " 1 use old engine (faster for eg easytags?)
  set regexpengine=1

  set mouse=a

  " no toolbar
  set guioptions-=T

  "save with ctrl-s
  nnoremap <silent> <C-S> :<C-u>Update<CR>
  inoremap <c-s> <c-o>:Update<CR>

  "gui tabs
  source $HOME/.vim/tabs.vim
  noremap <c-tab> :tabnext<cr>
  noremap <c-s-tab> :tabprev<cr>

  if !has("gui_macvim")
    nnoremap <C-w> :conf q<CR>
    inoremap <C-w> <Esc>:conf q<CR>
  endif

  " use ctrl + mousewheel to change font size
  nnoremap <C-Up> :silent! let &guifont = substitute(&guifont, '\d\+', '\=eval(submatch(0)+1)',     '')<CR>
  nnoremap <C-Down> :silent! let &guifont = substitute(&guifont, '\d\+', '\=eval(submatch(0)-1)    ', '')<CR>

  "set showtabline=2 " always show tabbar, fixes resizing issues
else
  "some terminal speed-ups
  set nocursorline
  set lazyredraw
  set nocursorcolumn
endif

