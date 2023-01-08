local map = require("noks.configs.utils").map

-- +----------------------------------------------------------+
-- | GENERAL                                                  |
-- +----------------------------------------------------------+

map("n", "<leader>nf", ":lua require('neogen').generate()<CR>")
map("n", ",T", "<Plug>PlenaryTestFile")
map("n", ",0d", ":.,6d<CR>")
map("n", ",sh", ":w !sh<CR>")
map("n", ",rr", ":luafile %<CR>")
map("n", "<Leader>rr", ":LspRestart <CR>")
map("n", ";f", "v/{<CR>%V")
-- exec last cmd
map("n", ",cc", ":,@:<CR>")

map("n", ",p", '"0p')
map("n", ",P", '"0P')

map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true, desc = "if j > 5 then add to jumplist" })
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . 'k']], { expr = true, desc = "if k > 5 then add to jumplist" })

map("t", "<C-x>", "<C-\\><C-n>")

map("x", "<leader>bs", ":!boxes -d stone")
-- " Replace word under cursor in file (case-sensitive)
map("n", "<leader>sr", "*:%s///gI<left><left><left>")
-- " Replace word under cursor in line (case-sensitive)
map("n", "<leader>sl", "*:s///gI<left><left><left>")

map("n", "Y", "y$")
map("n", "J", "mzJ`z")
map("n", "cn", "*``cgn")
map("n", "cN", "*``cgN")

map("n", "<C-d>", "6j")
map("n", "<C-u>", "6k")
map("n", "<leader>Y", 'gg"+yG')
map("n", "<esc>", ":noh<return><esc>")
map("n", ",fn", ":put =expand('%:t')<CR>")
map("n", "<F1>", ":FlutterRun<CR>")
map("n", "<F2>", ":FlutterRestart<CR>")

-- " Visually select the text that was last edited/pasted (Vimcast#2).
map("n", "gV", "`[v`")
map("n", "<leader>r", ":source ~/.config/nvim/init.vim<CR>")
map("n", "<leader>cd", ":lcd %:p:h")
map("n", "q;", ":q!<CR>")

map("n", ",fn", ":put =expand('%:t')<CR>")

map("i", "jk", "<Esc>")
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("v", "<leader>p", '"_dP')

map("v", "<", "<gv")
map("v", ">", ">gv")

-- " faster macros
-- map("n", "@", ":execute 'noautocmd norm! ' . v:count1 . '@'. getcharstr()<cr>")
-- map("v", "@", ":<C-U>execute 'noautocmd '<,'>norm! '. v:count1 . '@'. getcharstr()<cr>")
--#region

map("n", "<Leader><Leader>i", "<cmd>IconPickerNormal alt_font symbols nerd_font emoji<cr>")
-- map("n", "<Leader><Leader>y", "<cmd>IconPickerYank alt_font symbols nerd_font emoji<cr>") --> Yank the selected icon into register
-- map("i", "<C-i>", "<cmd>IconPickerInsert emoji<cr>")

-- +----------------------------------------------------------+
-- | WINDOWS & BUFFERS                                        |
-- +----------------------------------------------------------+

map("n", "<M-h>", "<C-w>h")
map("n", "<M-k>", "<C-w>k")
map("n", "<M-j>", "<C-w>j")
map("n", "<M-l>", "<C-w>l")
map("n", "<leader>w", "<C-w>w ")
map("n", "<C-s>", ":w<CR>")
map("n", "<C-c>", "<Esc>")
map("n", "<leader>bd", ":bd%<CR>")
map("n", "<leader>Q", ":q<CR>")
map("n", "<leader>+", ":vertical resize +15<CR>")
map("n", "<leader>-", ":vertical resize -15<CR>")
map("n", "<leader>cA", ":w <bar> %bd <bar> e# <bar> bd# <CR>")
map("n", "<leader>CC", ":call CleanNoNameEmptyBuffers()<CR>")
map("n", "<Backspace>", "<C-^>")
map("i", "<C-s>", "<ESC>:w<CR>")

map("n", "<Leader>vc", ":NvimTreeToggle<CR>")

-- " ----------------------------------------------------------------------------
-- " Go  remaps
-- " ----------------------------------------------------------------------------

map("n", "<Leader>ga", ":GoAlt<CR>")

-- " ----------------------------------------------------------------------------
-- " Harpoon
-- " ----------------------------------------------------------------------------

map("n", "<M-a>", ":lua require('harpoon.mark').add_file()<CR>")
map("n", "<M-m>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
map("n", "<M-c>", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>")
map("n", "<M-1>", ":lua require('harpoon.ui').nav_file(1)<CR>")
map("n", "<M-2>", ":lua require('harpoon.ui').nav_file(2)<CR>")
map("n", "<M-3>", ":lua require('harpoon.ui').nav_file(3)<CR>")
map("n", "<M-4>", ":lua require('harpoon.ui').nav_file(4)<CR>")
map("n", "<M-5>", ":lua require('harpoon.ui').nav_file(5)<CR>")
map("n", "<M-0>", ":lua require('harpoon.term').gotoTerminal(1)<CR>")
map("n", "<M-9>", ":lua require('harpoon.term').sendCommand(1, 1)<CR>")

-- "---------------------------------------------------------------------------
-- " Quickfix
-- " ----------------------------------------------------------------------------

map("n", "]q", ":cnext<cr>zz")
map("n", "[q", ":cprev<cr>zz")
map("n", "]l", ":lnext<cr>zz")
map("n", "[l", ":lprev<cr>zz")

-- " quickfix mapping, nextfile jumps
map("n", "<Up>", ":cprevious<CR>")
map("n", "<Down>", ":cnext<CR>")
map("n", "<Left>", ":cpfile<CR>")
map("n", "<Right>", ":cnfile<CR>")

-- ----------------------------------------------------------------------------
-- LSP THINGS
-- ----------------------------------------------------------------------------

map("n", "<M-CR>", ":Lspsaga code_action<CR>")
map("n", "K", ":Lspsaga hover_doc<CR>")
map("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>")
map("n", "]d", ":Lspsaga diagnostic_jump_next<CR>")
map("n", "[i", ":Lspsaga show_line_diagnostics<CR>")

map("v", "<M-CR>", ":<C-U>Lspsaga range_code_action<CR>")

map("n", "gD", ":Lspsaga peek_definition<CR>")
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
map("n", "gdv", ":vs | lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")

map("n", "gr", ":lua vim.lsp.buf.references()<CR>")
map("n", "<leader>dll", ":lua vim.diagnostic.setloclist()<CR>")
map("n", "<leader>dle", ":lua vim.diagnostic.setloclist({severity=vim.diagnostic.severity.ERROR})<CR>")
map("n", "<leader>dqq", ":lua vim.diagnostic.setqflist()<CR>")
map("n", "<leader>f", ":lua vim.lsp.buf.format({async=true})<CR>")
-- ----------------------------------------------------------------------------
-- TELESCOPE
-- ----------------------------------------------------------------------------

map("n", "<leader>ps", ":Telescope find_files<cr>")
map("n", "<leader>pl", ":Telescope live_grep<cr>")
map("n", "<leader>pp", ":Telescope projects<cr>")
map("n", "<leader>sd", ":lua require('noks.configs.telescope').search_dotfiles()<CR>")
map("n", "<leader>fq", ":lua require('noks.configs.telescope').live_grep_qflist()<CR>")
map("n", "<leader>sw", ":lua require('noks.configs.telescope').search_wallpapers()<CR>")
map("n", "<leader>ds", ":lua require('noks.configs.telescope').document_symbols()<CR>")
map("n", "<leader>mm", ":lua require('noks.configs.telescope').man_pages()<CR>")
map("n", "<leader>no", ":lua require('noks.configs.telescope').notifications()<CR>")

map("n", "<leader>tg", ":Telescope grep_string<CR>")

map("n", "<leader>H", ":Telescope help_tags<CR>")
map("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>")
map("n", "<C-b>", ":Telescope buffers<cr>")
map("n", ";t", ":Telescope<cr>")
map("n", ";T", ":Telescope resume<cr>")

map("n", "<leader>em", ":lua require'telescope.builtin'.symbols{ sources = {'emoji'} }<CR>")
map("n", "<leader>eg", ":lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<CR>")

-- ----------------------------------------------------------------------------
-- Testing
-- ----------------------------------------------------------------------------

map("n", "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
map("n", "<leader>to", ":lua require('neotest').output.open({ enter = true })<CR>")
map("n", "<leader>tn", ":lua require('neotest').run.run()<CR>")
map("n", "<leader>ts", ":lua require('neotest').summary.toggle()<CR>")

map("n", "[t", ":lua require('neotest').jump.prev({ status = 'failed' })<CR>")
map("n", "]t", ":lua require('neotest').jump.next({ status = 'failed' })<CR>")
-- map("n", "<leader>ts", ":TestSuite<CR>")
-- map("n", "<leader>tl", ":TestLast<CR>")

-- " ----------------------------------------------------------------------------
-- " Git
-- " ----------------------------------------------------------------------------

map("n", "<leader>gB", ":G blame<CR>")
map("n", "<leader>gs", ":G<CR>")
map("n", "<leader>ge", ":Ge:<CR>")
map("n", "<leader>gb", ":lua require('noks.configs.telescope').git_branches()<CR>")
map("n", "<leader>gdi", ":Telescope git_bcommits<CR>")
map("n", "<leader>tr", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
map("n", "<leader>tc", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")
map("n", "<leader>mf", ":lua require('telescope').extensions.media_files.media_files()<CR>")
map("n", "<leader>gm", ":G mergetool<CR>")
map("n", "<leader>gqq", ":Gitsigns setqflist all<CR>")
map("n", "<leader>gcl", ":0Gclog<CR>")
map("n", "<leader>gcd", ":Gclog -- %<CR>")
map("n", "<leader>gl", ":diffget //3<CR>")
map("n", "<leader>gh", ":diffget //2<CR>")
map("n", "<leader>gp", ":Octo pr list<CR>")

-- " ----------------------------------------------------------------------------
-- " DAP
-- " ----------------------------------------------------------------------------
map("n", "<F5>", ":lua require'dap'.continue()<CR>")
map("n", "<F9>", ":lua require'dap'.step_over()<CR>")
map("n", "<F10>", ":lua require'dap'.step_into()<CR>")
map("n", "<F12>", ":lua require'dap'.step_out()<CR>")
map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
map("n", "<leader>d?", ":lua require'dapui'.float_element('scopes')<CR>")
map("n", "<leader>dw", ":lua require'dap.ui.widgets'.hover()<CR>")
map("n", "<M-i>", ":lua require('dapui').eval()<CR>")
map("n", "<M-\\>", ":lua require('dapui').toggle()<CR>")
map("n", "<M-o>", ":lua require('dapui').float_element()<CR>")
