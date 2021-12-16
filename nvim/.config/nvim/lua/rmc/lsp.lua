local lspconfig = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local coq = require("coq")
local lsp = vim.lsp
local handlers = lsp.handlers
local lsp_installer = require("nvim-lsp-installer")
local utils = require("rmc.utils")
local null_ls = require("null-ls")

USER = vim.fn.expand("$USER")

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
	sumneko_root_path = "/Users/" .. USER .. "/Documents/code/lua-language-server"
	sumneko_binary = "/Users/" .. USER .. "/Documents/code/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
	sumneko_root_path = "/home/" .. USER .. "/code/lua-language-server"
	sumneko_binary = "/home/" .. USER .. "/code/lua-language-server/bin/Linux/lua-language-server"
else
	print("Unsupported system for sumneko")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local coq_capabilities = coq.lsp_ensure_capabilities(capabilities)
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = coq_capabilities,
		on_attach = on_attach,
	}

	if server.name == "pyright" then
		local pyopts = {
			settings = {
				pyright = {
					disableOrganizeImports = false,
					analysis = {
						useLibraryCodeForTypes = true,
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						autoImportCompletions = true,
					},
				},
			},
		}
		utils.merge(opts, pyopts)
	end

	server:setup(opts)
end)

lspconfig.tsserver.setup({
	capabilities = coq_capabilities,
	on_attach = function(client, bufnr)
		local ts_utils = require("nvim-lsp-ts-utils")

		ts_utils.setup({
			debug = true,
			disable_commands = false,
			enable_import_on_completion = false,

			-- import all
			import_all_timeout = 5000, -- ms
			-- lower numbers = higher priority
			import_all_priorities = {
				same_file = 1, -- add to existing import statement
				local_files = 2, -- git files or files with relative path markers
				buffer_content = 3, -- loaded buffer content
				buffers = 4, -- loaded buffer names
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = true,
			inlay_hints_highlight = "Comment",

			-- update imports on file move
			update_imports_on_move = false,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		local opts = { silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
	end,
})

lspconfig.html.setup({
	capabilities = coq_capabilities,
	on_attach = on_attach,
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = coq_capabilities,
})

lspconfig.sumneko_lua.setup({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = on_attach,
	capabilities = coq_capabilities,
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
				path = vim.split(package.path, ";"),
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
	dev_log = {
		open_cmd = "tabnew",
	},
	debugger = {
		enabled = true,
	},
	lsp = {
		on_attach = function(_, bufnr)
			handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				virtual_text = false,
				underline = true,
			})

			on_attach(_, bufnr)
		end,
		capabilities = coq_capabilities,
	},
})

null_ls.setup({
	sources = {
		-- null_ls.builtins.diagnostics.eslint_d,
		-- null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
		null_ls.builtins.formatting.prettier.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"yaml",
				"markdown",
				"graphql",
			},
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
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
