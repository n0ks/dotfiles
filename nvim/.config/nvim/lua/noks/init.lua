require("impatient").enable_profile()
require("noks.configs.keymaps")
require("noks.configs.treesitter")
require("noks.configs.utils")
require("noks.configs.autocmds")
-- require('noks.configs.coq')
require("noks.configs.luasnip")
require("noks.configs.cmp")
require("noks.lsp.lsp-saga")
require("noks.lsp.lsp-installer")
require("noks.lsp.init").setup()
require("noks.configs.telescope")
require("noks.configs.lualine")
require("noks.configs.gitsigns")
require("noks.configs.dap")
-- require("noks.configs.projects")
require("noks.configs.projectionist")
require("noks.configs.harpoon")
require("noks.configs.bqf")
require("neogen").setup()
require("bufresize").setup()
require("noks.configs.venn")
require("noks.globals")
require("nvim-autopairs").setup({})
require("noks.configs.theme")
require("noks.configs.comment")
--require("diffview").setup({})
-- require("presence"):setup()
