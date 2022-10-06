require("impatient").enable_profile()
require("noks.configs.keymaps")
require("noks.configs.treesitter")
require("noks.configs.utils")
require("noks.configs.autocmds")
require("noks.configs.luasnip")
require("noks.configs.cmp")
require("noks.lsp.lsp-saga")
require("noks.lsp.mason")
require("noks.lsp.init").setup()
require("noks.configs.telescope")
require("noks.configs.lualine")
require("noks.configs.gitsigns")
require("noks.configs.neotest")
require("noks.configs.dap")
require("noks.configs.projectionist")
require("noks.configs.harpoon")
require("noks.configs.bqf")
require("neogen").setup()
require("bufresize").setup()
require("noks.configs.venn")
require("noks.globals")
require("noks.configs.autopairs")
require("noks.configs.comment")
require("noks.configs.dressing")
require("noks.configs.surround")
require("noks.configs.octo")
require("icon-picker").setup({
	disable_legacy_commands = true,
})

