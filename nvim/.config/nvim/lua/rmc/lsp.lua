local nvim_lsp = require("lspconfig")

local sumneko_root_path = vim.fn.getenv("HOME") .. "/Documents/Projects/github/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

-- require'lspinstall'.setup() -- important

-- local servers = require'lspinstall'.installed_servers()
-- for _, server in pairs(servers) do
--   require'lspconfig'[server].setup{}
-- end

local runtime_path = vim.split(package.path, ";")

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
})

require("lspconfig").yamlls.setup({
	on_attach = on_attach,
})

require("lspconfig").sumneko_lua.setup({
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
	lsp = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
})
