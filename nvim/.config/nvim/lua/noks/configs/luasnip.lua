require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
local ls = require("luasnip")
ls.filetype_extend("dart", { "flutter", "flutter_bloc" })

ls.config.set_config({
	history = true,
	updateevents = "TextChanged, TextChangedI",
	enable_autosnippets = true,
})
