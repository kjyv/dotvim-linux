"get this file's location (to be relative for e.g. neovim)
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" load plugins

" install vim-plug and plugins (if not already existing)
if empty(glob(s:path."/autoload/plug.vim"))
    execute '!curl -fLo '.s:path.'/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let mapleader=','
let g:mapleader = ","

call plug#begin(s:path.'/plugged')

" theming
Plug 'NLKNguyen/papercolor-theme'

" Preview e.g. regexp patterns
Plug 'markonm/traces.vim'

" use fzf to find files and rg to find in files
" :Files :Ag :History :Commits etc.
Plug 'junegunn/fzf.vim' | Plug '/opt/homebrew/opt/fzf'
let g:fzf_vim = {}
let g:fzf_vim.buffers_jump = 1
let g:fzf_action = { 'enter': 'tab split' }
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

" custom ProjectFiles command to start at .git level
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

nmap <C-p> :ProjectFiles<CR>

"https://github.com/puremourning/vimspector
"https://github.com/neoclide/coc.nvim

" allow selection also on blocks for python
" via text objects (e.g. "vai" or "vii")
Plug 'michaeljsmith/vim-indent-object'

" comment out code with "gc" (visual mode) or "gcc" (current line)
Plug 'tpope/vim-commentary'

" surround things, e.g. select in visual mode, then S' (or yse' in normal mode for next word) or cs'" to change from ' to "
Plug 'tpope/vim-surround'

" completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
" no docstring popup
autocmd FileType python setlocal completeopt-=preview

" Plug 'girishji/vimcomplete'
" set noNewlineInCompletionEver = true

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

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

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
let NERDTreeShowHidden=0

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

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
let g:easytags_async = 1
let g:easytags_always_enabled = 1
let g:easytags_syntax_keyword = 'always'
let g:easytags_python_enabled = 0

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <leader>w <plug>(easymotion-w)
map <leader>b <plug>(easymotion-b)

" show context of current position at the top
Plug 'wellle/context.vim'
" let g:context_enabled = 1

" format code
" Plug 'sbdchd/neoformat'

" linting
Plug 'w0rp/ale'
let g:ale_lint_delay = 25
"let g:ale_linters = {'python': ['mypy', 'ruff'], 'lint_file':1}
let g:ale_linters = {'python': ['pyright', 'ruff', 'ruff_format'], 'lint_file':1}
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['ruff', 'ruff_format'], }
let g:ale_fix_on_save = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight ALEError ctermbg=none guibg=NONE gui=undercurl guisp=red
autocmd ColorScheme * highlight ALEVirtualTextError ctermfg=red guifg=red
autocmd ColorScheme * highlight ALEVirtualTextWarning ctermfg=yellow guifg=yellow
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1

function ALELSPMappings()
    let lsp_found=0
    for linter in ale#linter#Get(&filetype)
        if !empty(linter.lsp) && ale#lsp_linter#CheckWithLSP(bufnr(''), linter)
            let lsp_found=1
        endif
    endfor
    if (lsp_found)
        nnoremap <buffer> K :ALEDocumentation<cr>
        nnoremap <buffer> gr :ALEFindReferences<cr>
        nnoremap <buffer> gd :ALEGoToDefinition<cr>
        "binding this is still not suported: https://github.com/macvim-dev/macvim/issues/1325
        "C-LeftMouse is already mapped to this (not sure from where)
        noremap <buffer> <D-LeftMouse> gd
        nnoremap <buffer> gy :ALEGoToTypeDefinition<cr>
        nnoremap <buffer> gh :ALEHover<cr>

        setlocal omnifunc=ale#completion#OmniFunc
    endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()

" git support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" automatically switch off relative numbers when they are not useful
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" improved html indenting and syntax
Plug 'othree/html5.vim'
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
Plug 'pangloss/vim-javascript'

" visual debugger
" Plug 'puremourning/vimspector'

" all Plugins must be added before the following line
call plug#end()

set t_Co=256
set background=dark
colorscheme PaperColor

"night mode
let os=substitute(system('uname'), '\n', '', '')
if has("gui_running") && os != "Darwin"
    "Note: macOS dark mode is handled using system setting in macos.vim, so this is only for other
    "systems
    if strftime("%H") >= 7 && strftime("%H") < 21
        set background=light
    endif
endif

" disallow potentially insecure modelines
set nomodeline

" source some other files
if os == "Darwin"
    execute "source ".s:path."/macos.vim"
    execute "source ".s:path."/tex.vim"
endif

execute "source ".s:path."/editing.vim"
execute "source ".s:path."/interface.vim"
execute "source ".s:path."/stripWhitespace.vim"
execute "source ".s:path."/last_position.vim"
execute "source ".s:path."/persistent_undo.vim"
execute "source ".s:path."/highlightCursor.vim"

" show matching brace etc. upon insertion of the second one
filetype plugin on
runtime macros/matchit.vim


