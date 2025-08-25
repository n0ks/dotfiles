local fn = vim.fn
local api = vim.api

local on_buf_load = { "BufNewFile", "BufRead" }

-- ╭───────────────────────╮
-- │ Autocmd Groups        │
-- ╰───────────────────────╯
local qflist_group = api.nvim_create_augroup("QFlist", { clear = true })
local highlight_yank_group = api.nvim_create_augroup("highlight_yank", { clear = true })
local read_file_on_change_group = api.nvim_create_augroup("read_file_on_change", { clear = true })
local lsp_node = api.nvim_create_augroup("LspNodeModules", { clear = true })

-- ╭──────────────────────────────╮
-- │ Set filetype or options     │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	command = "setl buffhidden=delete",
})

api.nvim_create_autocmd("FileType", {
	pattern = { "help", "startuptime", "qf", "lspinfo", "fugitive", "null-ls-info" },
	command = "nnoremap <buffer><silent> q :close<CR>",
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "Fastfile", "Podfile" },
	command = "setl filetype=ruby",
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.arb",
	command = "setl filetype=json",
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.tmpl",
	command = "setl filetype=html",
})

api.nvim_create_autocmd("FileType", {
	pattern = "json",
	command = "setl filetype=jsonc",
})

api.nvim_create_autocmd("BufRead", {
	pattern = "*.yaml",
	command = "set sw=2 sts=2 expandtab",
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*/node_modules/*",
	command = "lua vim.diagnostic.disable(0)",
	group = lsp_node,
})

-- ╭──────────────────────────────╮
-- │ Highlight on yank           │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = highlight_yank_group,
	callback = function()
		vim.highlight.on_yank({
			timeout = 40,
			on_visual = true,
			higroup = "IncSearch",
		})
	end,
})

-- ╭──────────────────────────────╮
-- │ Restore cursor position     │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
			fn.setpos(".", fn.getpos("'\""))
			api.nvim_feedkeys("zz", "n", true)
		end
	end,
})

-- ╭──────────────────────────────╮
-- │ Disable completion in tree  │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("BufEnter", {
	pattern = "*NvimTree*",
	callback = function()
		vim.b.completion = false
	end,
})

-- ╭──────────────────────────────╮
-- │ Format go files             │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	command = 'lua require("go.format").gofmt()',
})
