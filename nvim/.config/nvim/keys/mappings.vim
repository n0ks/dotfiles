" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------
inoremap  jk <Esc>
inoremap  kj <Esc>
" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$
nnoremap J mzJ`z
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap cn *``cgn
nnoremap cN *``cgN
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
" Visually select the text that was last edited/pasted (Vimcast#26).
noremap gV `[v`]
nmap gx :!open <c-r><c-a> 
nmap ,p "0p
nmap ,P "0P
nnoremap <silent><leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>cd :lcd %:p:h
vnoremap < <gv
vnoremap > >gv
noremap q; :q
" paste last thing yanked
vnoremap <leader>p "_dP
nnoremap <C-d> 6j
nnoremap <C-u> 6k
nnoremap <leader>Y gg"+yG
nnoremap <silent><CR> :noh<return><esc>
nnoremap <silent><esc> :noh<return><esc>
nnoremap ,fn :put =expand('%:t')<CR>
nnoremap <F1> :FlutterRun<CR>
nnoremap <F2> :FlutterRestart<CR>
tnoremap <C-[> <C-\><C-n>
nmap sj :SplitjoinSplit<CR>
nmap sk :SplitjoinJoin<CR>

" Replace word under cursor in file (case-sensitive)
nmap <leader>sr *:%s///gI<left><left><left>
" Replace word under cursor in line (case-sensitive)
nmap <leader>sl *:s///gI<left><left><left>

" ----------------------------------------------------------------------------
" WINDOWS & BUFFERS
" ----------------------------------------------------------------------------
nnoremap <silent><TAB> :bnext<CR>
nnoremap <silent><S-TAB> :bprevious<CR>
nnoremap <M-h> <C-w>h
nnoremap <M-k> <C-w>k
nnoremap <M-j> <C-w>j
nnoremap <M-l> <C-w>l
nnoremap <leader>w <C-w>w 
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
nnoremap <C-c> <Esc>
nnoremap <leader>bd :bd%<CR>
nnoremap <leader>Q :q<CR>
nnoremap <leader>+ :vertical resize +15<CR>
nnoremap <leader>- :vertical resize -15<CR>
nnoremap <leader>cA :w <bar> %bd <bar> e# <bar> bd# <CR>
nnoremap <silent><leader>CC :call CleanNoNameEmptyBuffers()<CR>
nnoremap <Backspace> <C-^>

"---------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------

nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" quickfix mapping, nextfile jumps
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" ----------------------------------------------------------------------------
" Git
" ----------------------------------------------------------------------------

nnoremap <leader>gB :G blame<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>ge :Ge:<CR>
nnoremap <leader>gb :Telescope git_branches<CR>
nnoremap <leader>gdi :Telescope git_bcommits<CR>
nnoremap <leader>tr :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>tc :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
nnoremap <leader>gm :G mergetool<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gh :diffget //2<CR>

" ----------------------------------------------------------------------------
" Testing
" ----------------------------------------------------------------------------

nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tg :TestVisit<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>ts :TestSuite<CR>

" ----------------------------------------------------------------------------
" Harpoon
" ----------------------------------------------------------------------------

nnoremap <M-a> :lua require("harpoon.mark").add_file()<CR>
nnoremap <M-m> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <M-1> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <M-2> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <M-3> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <M-4> :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <M-5> :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <M-0> :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <M-9> :lua require("harpoon.term").sendCommand(1, "ls -la")<CR>


" ----------------------------------------------------------------------------
" LSP
" ----------------------------------------------------------------------------

nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap gi <CR><cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <C-k> <CR><cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
 
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>di <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <leader>dq <cmd>lua vim.lsp.diagnostic.set_qflist()<CR>
nnoremap <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>lf <cmd>lua require('stylua-nvim').format_file()<CR>
nnoremap <leader>ss <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>

nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap [i <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" ----------------------------------------------------------------------------
" SAGA
" ----------------------------------------------------------------------------

nnoremap <silent><M-CR> :Lspsaga code_action<CR>
vnoremap <silent><M-CR> :<C-U>Lspsaga range_code_action<CR>
" nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent><C-k> :Lspsaga preview_definition<CR>
" -- scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" nnoremap [d :Lspsaga diagnostic_jump_prev<CR>
" nnoremap ]d :Lspsaga diagnostic_jump_next<CR>


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
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dk :lua require'dap.ui.variables'.hover()<CR>
nnoremap <silent> <leader>dK :<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
nnoremap <silent> <leader>dw <cmd>lua require'dap.ui.widgets'.hover()<CR>
nnoremap <silent><M-i> :lua require("dapui").eval()<CR>
nnoremap <M-\> :lua require("dapui").toggle()<CR>
nnoremap <silent><M-o> :lua require("dapui").float_element()<CR>

" ----------------------------------------------------------------------------
" VSNIP
" ----------------------------------------------------------------------------

imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)' : '<C-j>'
nnoremap <leader>x  :VsnipYank key <bar> VsnipOpen <CR>

" ----------------------------------------------------------------------------
" TELESCOPE
" ----------------------------------------------------------------------------

nnoremap <leader>ps <cmd>Telescope find_files prompt_prefix=🗄 <cr>
nnoremap <leader>pl <cmd>Telescope live_grep prompt_prefix=🔍<cr>
nnoremap <leader>pb <cmd>Telescope buffers<cr>
nnoremap <leader>ph <cmd>Telescope help_tags<cr>
nnoremap <leader>sb :lua require('rmc.telescope').search_bv()<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>pp <cmd>Telescope projects<cr>
nnoremap <leader>sd :lua require('rmc.telescope').search_dotfiles()<CR>
command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})

