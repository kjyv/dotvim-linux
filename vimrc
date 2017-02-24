"get this file's location (to be relative for e.g. neovim)
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" load plugins

" install vim-plug and plugins (if not already existing)
if empty(glob(s:path."/autoload/plug.vim"))
    execute '!curl -fLo '.s:path.'/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(s:path.'/plugged')

" fuzzy file opening
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'rc'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"open in tabs
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>']
    \ }

" allow block selection also on indents
Plug 'michaeljsmith/vim-indent-object'

" completion

" code static analysis and completion
Plug 'davidhalter/jedi-vim'
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#smart_auto_mappings = 0

""disable some stuff for performance
let g:jedi#show_call_signatures = 1
let g:jedi#popup_on_dot = 0

autocmd FileType python set omnifunc=pythoncomplete#Complete
" no docstring popup
autocmd FileType python setlocal completeopt-=preview

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionTypeDiscovery = [
      \ "&omnifunc:<c-x><c-o>",
      \ "&completefunc:<c-x><c-u>",
      \ ]
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 1

" cmds tab completion
set wildmode=longest,list,full
set wildmenu

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

"Plug 'maralla/completor.vim'
"let g:jedi#completions_enabled = 0
"let g:completor_auto_trigger = 0
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
let g:easytags_async = 1
let g:easytags_always_enabled = 1
let g:easytags_syntax_keyword = 'always'
let g:easytags_python_enabled = 1

Plug 'mhinz/vim-startify'
set sessionoptions-=buffers
set sessionoptions-=help
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_autoload = 0
let g:startify_session_persistence = 0
let g:startify_change_to_dir = 1
let NERDTreeHijackNetrw = 0
if has("gui_running")
    autocmd VimLeave * NERDTreeTabsClose
    autocmd VimLeave * SDelete! default.vim
    autocmd VimLeave * SSave default.vim
    set shortmess+=O
endif

"nerdtree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
map <C-n> <plug>NERDTreeTabsToggle<CR>
let g:NERDTreeWinPos = "right"
"let NERDTreeMapOpenInTab='<ENTER>'
let g:NERDTreeWinSize=30
"let NERDTreeMouseMode=3 "TODO
"set switchbuf=useopen,usetab
map <leader>nf :NERDTreeTabsFind <CR>
map <leader>cw :NERDTreeCWD <CR>
"let g:nerdtree_tabs_autofind=1
let g:nerdtree_tabs_focus_on_files=1
"if has("gui_macvim")
    let g:nerdtree_tabs_open_on_gui_startup=0
"endif
let NERDTreeIgnore = ['\.pyc$']

Plug 'majutsushi/tagbar'
nnoremap <C-t> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_indent = 1
let g:tagbar_compact = 1
let g:tagbar_singleclick = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_foldlevel = 2
let g:tagbar_sort = 0
if has("gui_running")
    autocmd BufEnter * nested :call tagbar#autoopen(0)
endif

"if has('nvim')
"    Plug 'benekastah/neomake'
"    autocmd! BufWritePost * Neomake
"    let g:neomake_open_list=0
"    let g:neomake_list_height=3
"    let g:neomake_error_sign = {
"            \ 'text': '>>',
"            \ 'texthl': 'ErrorMsg',
"            \ }
"    hi MyWarningMsg ctermbg=3 ctermfg=0
"    let g:neomake_warning_sign = {
"            \ 'text': '>>',
"            \ 'texthl': 'MyWarningMsg',
"            \ }
"    Plug 'dojoteef/neomake-autolint'
"else
    Plug 'w0rp/ale'
    let g:ale_lint_delay = 100
    let g:ale_linters = {'python': ['pylint', 'flake8']}
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign

    "syntastic
"    Plug 'scrooloose/syntastic'
"    set statusline+=%#warningmsg#
"    if exists('g:loaded_syntastic_plugin')
"       set statusline+=%{SyntasticStatuslineFlag()}
"    endif
"    set statusline+=%*
"
"    let g:syntastic_always_populate_loc_list = 1
"    let g:syntastic_auto_loc_list = 1
"    let g:syntastic_check_on_open = 1
"    let g:syntastic_check_on_wq = 0
"    let g:syntastic_loc_list_height = 3
"    " set to passive mode for some (slow) filetypes
"    let g:syntastic_mode_map = {
"            \ "mode": "active",
"            \ "active_filetypes": [],
"            \ "passive_filetypes": ["python"] }
"endif

"latex-suite
"Plug 'gerw/vim-latex-suite'
Plug 'vim-latex/vim-latex'
let g:Imap_UsePlaceHolders = 0
let g:Tex_MathMenus = 0
let g:Tex_PackagesMenu = 0
"also consider: Plug 'lervag/vimtex'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'NLKNguyen/papercolor-theme'

" all Plugins must be added before the following line
call plug#end()

set t_Co=256
set background=light
colorscheme PaperColor

" source settings
execute "source ".s:path."/editing.vim"
execute "source ".s:path."/interface.vim"
execute "source ".s:path."/stripWhitespace.vim"
execute "source ".s:path."/last_position.vim"
execute "source ".s:path."/persistent_undo.vim"
execute "source ".s:path."/highlightCursor.vim"

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        execute "source ".s:path."/osx.vim"
        execute "source ".s:path."/tex.vim"
    endif
endif

