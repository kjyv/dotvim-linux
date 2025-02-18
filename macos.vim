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

" swipe bindings only work on macvim
map <SwipeLeft> <C-o>
map <SwipeRight> <C-i>

if has("gui_macvim")
    " open find in files and open fuzzy files
    nmap <D-F> :Rg<CR>
    nmap <D-T> :ProjectFiles<CR>
endif

if $TERM_PROGRAM =~ "iTerm"
    " show cursor line in insert mode also on terminal
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode

    " jump words with option-left/right
    map <Esc>b b
    map <Esc>f w
    imap <Esc>b <C-o>b
    imap <Esc>f <C-o>w

    " Cmd-Left and Cmd-Right to jump to start/end of the line
    map <Esc>H 0
    map <Esc>F $
endif
