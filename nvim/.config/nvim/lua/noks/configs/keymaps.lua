local map = require("noks.configs.utils").map

-- +----------------------------------------------------------+
-- | GENERAL                                                  |
-- +----------------------------------------------------------+

map("n", "<leader>nf", ":lua require('neogen').generate()<CR>")
map("n", ",T", "<Plug>PlenaryTestFile")
map("n", ",0d", ":.,6d<CR>")
map("n", ",sh", ":w !sh<CR>")
map("n", ",rr", ":luafile %<CR>")

-- exec last cmd
map("n", ",cc", ":,@:<CR>")

map("n", ",p", "0p")
map("n", ",P", "0P")

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

map("n", "<esc>", ":noh<return><esc>")
map("n", ",fn", ":put =expand('%:t')<CR>")

map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

map("v", "<leader>p", "_dP")
map("v", "<", "<gv")
map("v", ">", ">gv")

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

-- " ----------------------------------------------------------------------------
-- " Harpoon
-- " ----------------------------------------------------------------------------

map("n", "<M-a>", ":lua require('harpoon.mark').add_file()<CR>")
map("n", "<M-m>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
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
-- SAGA
-- ----------------------------------------------------------------------------

map("n", "<M-CR>", ":Lspsaga code_action<CR>")
map("n", "K", ":Lspsaga hover_doc<CR>")
map("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>")
map("n", "]d", ":Lspsaga diagnostic_jump_next<CR>")
map("n", "[i", ":Lspsaga show_line_diagnostics<CR>")

map("v", "<M-CR>", ":<C-U>Lspsaga range_code_action<CR>")

-- ----------------------------------------------------------------------------
-- TELESCOPE
-- ----------------------------------------------------------------------------

map("n", "<leader>ps", ":Telescope find_files<cr>")
map("n", "<leader>pl", ":Telescope live_grep<cr>")
map("n", "<leader>ph", ":Telescope help_tags<cr>")
map("n", "<leader>pp", ":Telescope projects<cr>")
map("n", "<leader>sd", ":lua require('noks.configs.telescope').search_dotfiles()<CR>")
map("n", "<leader>sw", ":lua require('noks.configs.telescope').search_wallpapers()<CR>")
map("n", "<leader>ds", ":lua require('noks.configs.telescope').document_symbols()<CR>")
map("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>")
map("n", "<C-b>", ":Telescope buffers<cr>")
map("n", ";t", ":Telescope<cr>")

map("n", "<leader>em", ":lua require'telescope.builtin'.symbols{ sources = {'emoji'} }<CR>")
map("n", "<leader>eg", ":lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<CR>")
