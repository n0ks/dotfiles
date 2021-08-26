local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local sumneko_root_path = vim.fn.getenv("HOME") .. "/Documents/Projects/github/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.cmd([[ command -buffer Formatting lua vim.lsp.buf.formatting() ]])
end
-- require'lspinstall'.setup() -- important

-- local servers = require'lspinstall'.installed_servers()
-- for _, server in pairs(servers) do
--   require'lspconfig'[server].setup{}
-- end

local runtime_path = vim.split(package.path, ";")

--INSTALL: -- npm i -g typescript typescript-language-server
nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
	settings = { documentFormatting = true },
})

nvim_lsp.angularls.setup({
	capabilities = capabilities,
})
nvim_lsp.html.setup({
	capabilities = capabilities,
})

nvim_lsp.yamlls.setup({
	on_attach = on_attach,
})

nvim_lsp.sumneko_lua.setup({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = on_attach,
	capabilities = capabilities,
	commands = {
		Format = {
			function()
				require("stylua-nvim").format_file()
			end,
		},
	},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

require("flutter-tools").setup({
	decorations = {
		statusline = {
			app_version = true,
			device = false,
		},
	},
	debugger = {
		enabled = true,
	},
	lsp = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
})

protocol.CompletionItemKind = {
	" Text", -- = 1
	"ƒ Method", -- = 2;
	"ƒ Function", -- = 3; or 
	" Constructor", -- = 4;
	"ƒ Field", -- = 5;
	" Variable", -- = 6;
	" Class", -- = 7;
	"ﰮ Interface", -- = 8;
	" Module", -- = 9;
	" Property", -- = 10;
	" Unit", -- = 11;
	" Value", -- = 12;
	"了Enum", -- = 13;
	" Keyword", -- = 14;
	"﬌ Snippet", -- = 15;
	" Color", -- = 16;
	" File", -- = 17;
	" Reference", -- = 18;
	" Folder", -- = 19;
	" EnumMember", -- = 20;
	" Constant", -- = 21;
	" Struct", -- = 22;
	"ﯓ Event", -- = 23;
	" Operator", -- = 24;
	" TypeParameter", -- = 25;
}
