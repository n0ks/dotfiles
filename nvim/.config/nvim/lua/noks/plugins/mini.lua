return {

	{ "echasnovski/mini.pairs", version = false, config = true },
	{ "echasnovski/mini.ai", version = false, config = true },
	{ "echasnovski/mini.surround", version = false, config = true },
	{ "echasnovski/mini.statusline", version = false, config = true },
	{
		"echasnovski/mini.files",
		version = false,
		config = function()
			require("mini.files").setup()
		end,
	},
}
