return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "js-debug-adapter" }) -- Ensure it's installed
				end,
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local config = {
				virtual_text = false,
				inlay_hints = false,
				float = true,
				signs = {
					text = {
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.INFO] = "◉",
						[vim.diagnostic.severity.WARN] = "",
					},
				},
				update_in_insert = true,
				underline = { severity = vim.diagnostic.severity.ERROR },
				format_notify = false,
				severity_sort = true,
			}

			vim.keymap.set("n", "gK", function()
				local new_config = not vim.diagnostic.config().virtual_lines
				vim.diagnostic.config({ virtual_lines = new_config })
			end, { desc = "Toggle diagnostic virtual_lines" })

			vim.diagnostic.config(config)


			-- Jump directly to the first available definition every time.
			-- vim.lsp.handlers["textDocument/definition"] = function(_, result)
			--   if not result or vim.tbl_isempty(result) then
			--     print("[LSP] Could not find definition")
			--     return
			--   end
			--
			--   if vim.islist(result) then
			--     vim.lsp.util.show_document(result[1], "utf-8")
			--   else
			--     vim.lsp.util.show_document(result, "utf-8")
			--   end
			-- end

			local servers = {
				lua_ls = require("noks.lsp.servers.sumneko"),
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
				-- go = require("noks.lsp.servers.go"),
				-- pyright = require("noks.lsp.servers.pyright"),
				jsonls = require("noks.lsp.servers.jsonls"),
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local ensure_installed = vim.tbl_keys(servers or {})

			require("mason-lspconfig").setup({
				handlers = {
					ensure_installed = ensure_installed,
					function(server_name)
						local server_config = servers[server_name] or {}

						server_config.capabilities =
							vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})

						lspconfig[server_name].setup(server_config)
					end,
				},
			})
		end,
	},
}
