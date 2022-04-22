-- ╭──────────────────╮
-- │ Helper functions │
-- ╰──────────────────╯

local autocmd = function(ftable, pattern, action, group)
	vim.api.nvim_create_autocmd(ftable, {
		group = group,
		pattern = pattern,
		command = action.command or nil,
		callback = action.callback or nil,
	})
end

local autogroup = function(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local qflist_group = autogroup("QFlist")
local highlight_yank_group = autogroup("highlight_yank")
local read_file_on_change_group = autogroup("read_file_on_change")
local lsp_node = autogroup("LspNodeModules")

autocmd({ "FileType" }, { "netrw" }, { command = "setl buffhidden=delete" })
autocmd({"BufWinEnter"}, { "*" }, { command = "startinsert" })

-- autocmd({ "BufNewFile", "BufRead" }, { "*.ts" }, {
-- 	callback = function()
-- 		vim.schedule(function()
-- 			vim.cmd([["setl filetype = typescript"]])
-- 		end)
-- 	end,
-- })

autocmd({ "BufNewFile", "BufRead" }, { "Fastfile", "Podfile" }, { command = "setl filetype=ruby" })

autocmd({ "BufRead" }, { "*.yaml" }, { command = "set sw=2 sts=2 expandtab" })

autocmd({ "BufWinEnter" }, { "quickfix" }, { command = "call SetQFControlVariable()" }, qflist_group)

autocmd({ "BufWinLeave" }, { "*" }, { command = "call UnsetQFControlVariable()" }, qflist_group)

autocmd({ "TextYankPost" }, { "*" }, {
	callback = function()
		vim.highlight.on_yank({ timeout = 40, on_visual = true })
	end,
}, highlight_yank_group)

autocmd(
	{ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" },
	{ "*" },
	{ command = "silent! checktime" },
	read_file_on_change_group
)

autocmd({ "BufRead" }, { "*/node_modules/*" }, { command = "lua vim.diagnostic.disable(0)" }, lsp_node)
autocmd({ "BufNewFile" }, { "*/node_modules/*" }, { command = "lua vim.diagnostic.disable(0)" }, lsp_node)
