"FZF CONFIG
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all --reverse'

let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}

let g:fzf_preview_window = 'right:40%'

let g:fzf_checkout_git_options = '--sort=-committerdate'

" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list'),  'ctrl-t': 'tab split',  'ctrl-x': 'split', 'ctrl-v': 'vsplit' }

