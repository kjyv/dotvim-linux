" Command-R will write, compile, and forward search--thanks to
" http://reference-man.blogspot.com/2011/09/fully-integrated-latex-in-macvim.html
" preview, switch back to main window
map <D-r> :w<cr><leader>ll<leader>ls
imap <D-r> <ESC><D-r>

"ignore some syntastic stuff
let g:Tex_IgnoredWarnings ='
    \"Underfull\n".
    \"Overfull\n".
    \"specifier changed to\n".
    \"You have requested\n".
    \"Missing number, treated as zero.\n".
    \"There were undefined references\n".
    \"Citation %.%# undefined\n".
    \"Marginpar on page %.%# moved\n".
    \"\oval, \circle, or \line size unavailable\n"'

" ignore all warnings below level 4
let g:TCLevel = 4

" one last thing for latex
let g:tex_flavor = 'latex'
let g:Tex_GotoError=0
