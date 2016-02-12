call NERDTreeAddKeyMap({'key': 't', 'callback': 'NERDTreeMyOpenInTab', 'scope': 'FileNode', 'override': 1 })
call NERDTreeAddKeyMap({ 'key': '<2-LeftMouse>', 'callback': 'NERDTreeMyOpenInTab', 'scope': "FileNode", 'override': 1})
call NERDTreeAddKeyMap({'key': g:NERDTreeMapOpenInTab, 'callback': 'NERDTreeMyOpenInTab', 'scope': 'FileNode', 'override': 1 })
call NERDTreeAddKeyMap({ 'key': '<2-LeftMouse>', 'scope': "FileNode", 'callback': "NERDTreeMyOpenInTab" })

function NERDTreeMyOpenInTab(node)
    call a:node.open({'reuse': "all", 'where': 't'})
endfunction



