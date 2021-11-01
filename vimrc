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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.swo,*.pyc,*.log,*.out
"open in tabs
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>']
    \ }
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore', 'requirements.txt', 'main.tex', 'setup.py', 'Makefile.in', '.gitignore']
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|Library'

if has("gui_macvim")
    map <S-LeftMouse> <C-]>
endif

"https://github.com/puremourning/vimspector
"https://github.com/neoclide/coc.nvim

" allow indents also on block selection
Plug 'michaeljsmith/vim-indent-object'

" completion

" code static analysis and completion
Plug 'davidhalter/jedi-vim'
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#smart_auto_mappings = 0

""disable some stuff for performance
let g:jedi#show_call_signatures = 0
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

"Plug 'Shougo/deoplete.nvim'
"if !has('nvim')
"    Plug 'roxma/nvim-yarp'
"    Plug 'roxma/vim-hug-neovim-rpc'
"endif
"let g:deoplete#enable_at_startup = 1
"Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
"Plug 'zxqfl/tabnine-vim'

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
autocmd Filetype html let b:tagbar_ignore = 1
if has("gui_running")
    autocmd BufEnter * nested :call tagbar#autoopen(0)
endif

" format code
Plug 'sbdchd/neoformat'

" linting
Plug 'w0rp/ale'
let g:ale_lint_delay = 50
"let g:ale_linters = {'python': ['mypy', 'pylint']}
let g:ale_linters = {'python': ['mypy'], 'lint_file':1}
highlight clear ALEErrorSign
highlight clear ALEWarningSign
"highlight ALEError ctermbg=none guibg=NONE gui=undercurl guisp=red
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1

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

" improved html indenting and syntax
Plug 'othree/html5.vim'
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

Plug 'pangloss/vim-javascript'

" all Plugins must be added before the following line
call plug#end()

set t_Co=256
set background=light
colorscheme PaperColor
" disallow potentially insecure modelines
set nomodeline

"night mode
if strftime("%H") >= 5 && strftime("%H") < 20
  set background=light
else
  set background=dark
endif

" source settings
execute "source ".s:path."/editing.vim"
execute "source ".s:path."/interface.vim"
execute "source ".s:path."/stripWhitespace.vim"
execute "source ".s:path."/last_position.vim"
execute "source ".s:path."/persistent_undo.vim"
execute "source ".s:path."/highlightCursor.vim"

filetype plugin on
runtime macros/matchit.vim

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        execute "source ".s:path."/osx.vim"
        execute "source ".s:path."/tex.vim"
    endif
endif

