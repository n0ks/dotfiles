" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------
" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
" paste last thing yanked
tnoremap <C-[> <C-\><C-n>
xnoremap <leader>bs :!boxes -d stone

" ----------------------------------------------------------------------------
" Testing
" ----------------------------------------------------------------------------

nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tg :TestVisit<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>ts :TestSuite<CR>

" ----------------------------------------------------------------------------
" LSP
" ----------------------------------------------------------------------------

nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gdv <cmd>vs \| lua vim.lsp.buf.definition()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
 
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>dll <cmd>lua vim.diagnostic.setloclist()<CR>
nnoremap <leader>dqq <cmd>lua vim.diagnostic.setqflist()<CR>
nnoremap <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>lf <cmd>lua require('stylua-nvim').format_file()<CR>
nnoremap <leader>ss <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>

" ----------------------------------------------------------------------------
" DAP
" ----------------------------------------------------------------------------

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>di :lua require'dap.ui.variables'.hover()<CR>
nnoremap <silent> <leader>d? :<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
nnoremap <silent> <leader>dw <cmd>lua require'dap.ui.widgets'.hover()<CR>
nnoremap <silent><M-i> :lua require("dapui").eval()<CR>
nnoremap <M-\> :lua require("dapui").toggle()<CR>
nnoremap <silent><M-o> :lua require("dapui").float_element()<CR>



" ----------------------------------------------------------------------------
" TELESCOPE
" ----------------------------------------------------------------------------

command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})


" faster macros
nnoremap @ <cmd>execute "noautocmd norm! " . v:count1 . "@" . getcharstr()<cr>
xnoremap @ :<C-U>execute "noautocmd '<,'>norm! " . v:count1 . "@" . getcharstr()<cr>
