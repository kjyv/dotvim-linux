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

" only for macvim
map <SwipeLeft> <C-o>
map <SwipeRight> <C-i>

" open find in files and open fuzzy files
nmap <D-F> :Rg<CR>
nmap <D-T> :ProjectFiles<CR>

" thing cursor also on terminal
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
