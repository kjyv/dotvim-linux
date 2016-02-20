if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    map <D-t> :CtrlP<CR>
endif

noremap <c-tab> :tabnext<cr>
noremap <c-s-tab> :tabprev<cr>
map <SwipeLeft> :tabprev<cr>
map <SwipeRight> :tabnext<cr>
