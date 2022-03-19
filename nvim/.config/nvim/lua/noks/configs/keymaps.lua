local map = require("noks.configs.utils").map

map("n", "<leader>nf", ":lua require('neogen').generate()<CR>")
map("n", ",T", "<Plug>PlenaryTestFile")
map("n", ",0d", ":.,6d<CR>")

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
