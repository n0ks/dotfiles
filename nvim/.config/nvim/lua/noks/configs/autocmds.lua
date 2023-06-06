-- ╭──────────────────╮
-- │ Helper functions │
-- ╰──────────────────╯

local fn = vim.fn
local api = vim.api

local autocmd = function(ftable, pattern, action, group)
	api.nvim_create_autocmd(ftable, {
		group = group,
		pattern = pattern or nil,
		command = action.command or nil,
		callback = action.callback or nil,
	})
end

local autogroup = function(name)
	api.nvim_create_augroup(name, { clear = true })
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local qflist_group = autogroup("QFlist")
local highlight_yank_group = autogroup("highlight_yank")
local read_file_on_change_group = autogroup("read_file_on_change")
local lsp_node = autogroup("LspNodeModules")

-- autocmd({ "CursorHold" }, { "" }, {
-- 	callback = function()
-- 		local opts = {
-- 			focusable = false,
-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
-- 			source = "always",
-- 			scope = "cursor",
-- 		}

-- 		vim.diagnostic.open_float(nil, opts)
-- 	end,
-- })

-- don't auto comment new line
autocmd({ "BufEnter" }, nil, { command = [[set formatoptions-=cro]] })

autocmd({ "FileType" }, { "netrw" }, { command = "setl buffhidden=delete" })

autocmd(
	"FileType",
	{ "help", "startuptime", "qf", "lspinfo", "fugitive", "null-ls-info" },
	{ command = [[nnoremap <buffer><silent> q :close<CR>]] }
)

-- autocmd({ "FileType" }, { "typescriptreact" }, { command = "set ft=typescript" })

-- autocmd({ "TermOpen" }, { "*" }, { command = "startinsert | set winfixheight" })

-- autocmd({ "BufNewFile", "BufRead" }, { "*.ts" }, {
-- 	callback = function()
-- 		vim.schedule(function()
-- 			vim.cmd([["setl filetype = typescript"]])
-- 		end)
-- 	end,
-- })
--
-- restore cursor position when opening file
autocmd({ "BufReadPost" }, { "*" }, {
	callback = function()
		if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
			fn.setpos(".", fn.getpos("'\""))
			api.nvim_feedkeys("zz", "n", true)
		end
	end,
})

autocmd({ "BufNewFile", "BufRead" }, { "Fastfile", "Podfile" }, { command = "setl filetype=ruby" })
autocmd({ "BufNewFile", "BufRead" }, { "*.arb" }, { command = "setl filetype=json" })

autocmd({ "Filetype" }, { "json" }, { command = "setl filetype=jsonc" })

autocmd({ "BufRead" }, { "*.yaml" }, { command = "set sw=2 sts=2 expandtab" })

-- autocmd({ "BufWinEnter" }, { "quickfix" }, { command = "call SetQFControlVariable()" }, qflist_group)

-- autocmd({ "BufWinLeave" }, { "*" }, { command = "call UnsetQFControlVariable()" }, qflist_group)

autocmd({ "TextYankPost" }, { "*" }, {
	callback = function()
		vim.highlight.on_yank({ timeout = 40, on_visual = true, higroup = "IncSearch" })
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

-- autocmd({ "BufWinLeave" }, { "*.*" }, { command = "mkview!" })
-- autocmd({ "BufWinEnter" }, { "*.*" }, { command = "silent loadview" })
