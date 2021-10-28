require("lspinstall").setup() -- important
local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local coq = require("coq")
local lsp = vim.lsp
local handlers = lsp.handlers

local sumneko_root_path = vim.fn.getenv("HOME") .. "/Documents/code/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local coq_capabilities = coq.lsp_ensure_capabilities(capabilities)

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- local pop_opts = { border = "rounded", max_width = 80 }
	--
	-- handlers["textDocument/hover"] = lsp.with(handlers.hover, pop_opts)
	-- handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, pop_opts)

end

local servers = require("lspinstall").installed_servers()
for _, server in pairs(servers) do
	require("lspconfig")[server].setup({
		capabilities = coq_capabilities,
		on_attach = on_attach,
	})
end

_G.lsp_organize_imports = function()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup({
	capabilities = coq_capabilities,
	on_attach = function(client, bufnr)
		-- disable tsserver formatting if you plan on formatting via null-ls
		-- client.resolved_capabilities.document_formatting = false
		-- client.resolved_capabilities.document_range_formatting = false

		local ts_utils = require("nvim-lsp-ts-utils")

		-- defaults
		ts_utils.setup({
			debug = true,
			disable_commands = false,
			enable_import_on_completion = true,

			-- import all
			import_all_timeout = 5000, -- ms
			import_all_priorities = {
				buffers = 4, -- loaded buffer names
				buffer_content = 3, -- loaded buffer content
				local_files = 2, -- git files or files with relative path markers
				same_file = 1, -- add to existing import statement
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,

			-- eslint
			eslint_enable_code_actions = true,
			eslint_enable_disable_comments = true,
			eslint_bin = "eslint_d",
			eslint_enable_diagnostics = true,
			eslint_opts = {},
			-- formatting
			enable_formatting = false,
			formatter = "eslint_d",
			formatter_opts = {},

			-- update imports on file move
			update_imports_on_move = true,
			require_confirmation_on_move = false,
			watch_dir = nil,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		local opts = { silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
	end,
})

--INSTALL: -- npm i -g typescript typescript-language-server
-- nvim_lsp.tsserver.setup({
-- 	on_attach = on_attach,
-- 	capabilities = coq_capabilities,
-- 	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
-- 	settings = { documentFormatting = true },
-- })

-- nvim_lsp.angularls.setup({
-- 	capabilities = coq_capabilities,
-- })

nvim_lsp.html.setup({
	capabilities = coq_capabilities,
})

nvim_lsp.yamlls.setup({
	on_attach = on_attach,
	capabilities = coq_capabilities,
})

nvim_lsp.sumneko_lua.setup({
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
				path = vim.split(package.path, ";")			},
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
