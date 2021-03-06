
function s:Cursor_Moved()
  if bufname ('%') =~ '^NERD_tree_'
    return
  endif
  let cur_pos = winline()
  if g:last_pos == 0
    setlocal cul
    let g:last_pos = cur_pos
    return
  endif
  let diff = g:last_pos - cur_pos
  if diff > 1 || diff < -1
    setlocal cul
  else
    setlocal nocul
  endif
  let g:last_pos = cur_pos
endfunction
autocmd CursorMoved,CursorMovedI * call s:Cursor_Moved()
let g:last_pos = 0
