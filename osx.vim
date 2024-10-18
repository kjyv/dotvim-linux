"if has("gui_macvim")
"    macmenu &File.New\ Tab key=<nop>
"    map <D-t> :CtrlP<CR>
"endif
"
function! ChangeBackground()
  if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark
  else
    set background=light
  endif

  try
    execute "AirlineRefresh"
  catch
  endtry
endfunction"

map <SwipeLeft> g;<cr>
map <SwipeRight> g,<cr>

" not suported yet it seems: https://github.com/macvim-dev/macvim/issues/1325
noremap <D-LeftMouse> <leader>gg
