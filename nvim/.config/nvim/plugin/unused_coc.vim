" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" function! s:show_documentation()
"   if &filetype == 'vim'
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

" Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" command! -nargs=0 FIXALL   :call     CocAction('fixAll')
" command! -nargs=0 DOQF   :call     CocAction('doQuickfix')

" " Use K for show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>


" " Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gdv :call CocAction('jumpDefinition', 'vsplit')<CR>
"nmap <silent> gy <Plug>(coc-type-definition)
""nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nmap <silent> rn <Plug>(coc-rename)

"Flutter maps
"nnoremap <leader><f5> :Telescope flutter commands<CR>
" nnoremap <leader>rs :CocCommand flutter.dev.hotRestart<CR>
" nnoremap <leader>rr :CocCommand flutter.dev.hotReload<CR>
" nmap <leader>fuc  :CocList --input=flutter commands<CR>
" nmap <leader>fq  :CocCommand flutter.dev.quit<CR>
" nmap <leader>fl  :CocCommand flutter.dev.openDevLog<CR>
" nmap <leader>fc  :CocCommand flutter.dev.clearDevLog<CR>
" nmap <leader><f11> :CocCommand flutter.dev.openDevToolsProfiler<CR>
" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)
" nmap <silent><leader>ac <Plug>(coc-codelens-action)
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>di <Plug>(coc-diagnostic-info)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <leader>o  :CocList outline<CR>
" nmap <leader>od  :CocDiagnostics <CR>
" nmap <leader>odi  :CocList --normal diagnostics <CR>
" imap <C-l> <Plug>(coc-snippets-expand)
" vmap <C-j> <Plug>(coc-snippets-select)
" imap <C-j> <Plug>(coc-snippets-expand-jump)   
" Use <leader>x for convert visual selected code to snippet
" xmap <leader>x  <Plug>(coc-convert-snippet)
" Search workspace symbols.

" let g:coc_global_extensions = [
"   \ 'coc-snippets',
"   \ 'coc-tsserver',
"   \ 'coc-eslint', 
"   \ 'coc-prettier', 
"   \ 'coc-json', 
"   \ 'coc-flutter',
"   \ 'coc-snippets',
"   \ 'coc-yaml',
"   \ 'coc-tslint-plugin',
"   \ 'coc-tsserver',
"   \ 'coc-emmet',
"   \ 'coc-css',
"   \ 'coc-html',
"   \ 'coc-json',
"   \ ]


" autocmd BufLeave *.json,*.vim,*.lua execute "silent! CocDisable"
" == AUTOCMD ================================ 
" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
" au BufNewFile,BufRead *.ts setlocal filetype=typescript
" au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

