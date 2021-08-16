" Disable netrw.
" let g:loaded_netrw  = 1
" let g:loaded_netrwPlugin = 1
" let g:loaded_netrwSettings = 1
" let g:loaded_netrwFileHandlers = 1
let g:fern#renderer = "nerdfont"

let g:fern#mark_symbol                       = '●'
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '
" Custom settings and mappings.
let g:fern#disable_default_mappings = 0

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction


noremap <silent> <Leader>vv :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=
noremap <silent> <Leader>vc :Fern %:h -drawer -reveal=% -toggle -width=30<CR><C-w>=


function! FernInit() abort

  nmap <buffer><expr>
        \ <Plug>(fern-my-expand-or-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-collapse)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer><nowait> l <Plug>(fern-my-expand-or-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> f <Plug>(fern-action-new-file)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> X <Plug>(fern-action-clipboard-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> t <Plug>(fern-action-mark:toggle)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)

  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

	function! s:on_highlight() abort
	  " Use brighter highlight on root node
	  highlight link FernRootSymbol Title
	  highlight link FernRootText   Title
	endfunction

	augroup my-fern-highlight
	  autocmd!
	  autocmd User FernHighlight call s:on_highlight()
	augroup END

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup ENDP
