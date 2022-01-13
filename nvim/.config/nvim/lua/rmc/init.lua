require('impatient').enable_profile()
require('rmc.theme')
require('rmc.treesitter')
require('rmc.coq')
require('rmc.lsp.init')
require('rmc.lsp.lsp-saga')
require('rmc.telescope')
require('rmc.lualine')
require('rmc.gitsigns')
require('rmc.dap')
require('rmc.projects')
require('rmc.projectionist')
require('rmc.harpoon')
require('rmc.utils')
require('bqf').setup()
require("bufresize").setup()
require('rmc.venn')

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "v", "g", ":VBoxD<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "v", "<leader>", ":VFill<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
