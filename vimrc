"get this file's location (to be relative for e.g. neovim)
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" source settings
execute "source ".s:path."/editing.vim"
execute "source ".s:path."/interface.vim"
execute "source ".s:path."/stripWhitespace.vim"

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        execute "source ".s:path."/osx.vim"
        execute "source ".s:path."/tex.vim"
    endif
endif

" load plugins

" install vim-plug and plugins (if not already existing)
if empty(glob(s:path."/autoload/plug.vim"))
    execute '!curl -fLo '.s:path.'/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(s:path.'/plugged')

" crtlp
Plug 'ctrlpvim/ctrlp.vim'
"let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rc'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>']
    \ }

" code tab completion (supertab+jedi)
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
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
autocmd FileType python setlocal completeopt-=preview

" cmds tab completion
set wildmode=longest,list,full
set wildmenu

" airline
Plug 'vim-airline/vim-airline'
set laststatus=2
let g:airline_powerline_fonts = 1

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
let g:easytags_async = 1
let g:easytags_always_enabled = 1

"nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }
map <C-n> <plug>NERDTreeTabsToggle<CR>
let g:NERDTreeWinPos = "right"
let NERDTreeMapOpenInTab='<ENTER>'
let g:NERDTreeWinSize=30
"let NERDTreeMouseMode=3 "TODO
set switchbuf=useopen,usetab
map <leader>nf :NERDTreeTabsFind <CR>

"taglist
Plug 'vim-scripts/taglist.vim'
nnoremap <C-t> :TlistToggle<CR>

"syntastic
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
if exists('g:loaded_syntastic_plugin')
   set statusline+=%{SyntasticStatuslineFlag()}
endif
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3

"latex-suite
Plug 'gerw/vim-latex-suite', { 'on': '<Plug>Tex_Compile' }
"also consider: Plug 'lervag/vimtex'

" all Plugins must be added before the following line
call plug#end()

