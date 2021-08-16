" Diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1

" Completion
inoremap <silent><expr> <c-space> completion#trigger_completion()
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_items_priority = {
      \ 'Field': 11,
      \ 'Function': 7,
      \ 'Variables': 7,
      \ 'Method': 10,
      \ 'Interfaces': 5,
      \ 'Constant': 5,
      \ 'Class': 5,
      \ 'Keyword': 4,
      \ 'UltiSnips' : 1,
      \ 'vim-vsnip' : 0,
      \ 'Buffers' : 1,
      \ 'TabNine' : 0,
      \ 'File' : 1,
      \ }

let g:completion_chain_complete_list = [
      \ {'complete_items': ['lsp', 'snippet', 'buffer', 'buffers']},
      \ {'mode': '<c-p>'},
      \ {'mode': '<c-n>'}
      \ ]

nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>ac    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> [g            :<c-u>PrevDiagnosticCycle<CR>
nnoremap <silent> ]g            :<c-u>NextDiagnosticCycle<CR>
