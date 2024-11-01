return {

	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		build = "make install_jsregexp",
		version = "2.2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			history = true,
			updateevents = "TextChanged, TextChangedI",
			enable_autosnippets = true,
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

			local ls = require("luasnip")

			ls.filetype_extend("dart", { "flutter", "flutter_bloc" })
			ls.filetype_extend("go", { "go" })
		end,
	},
}
