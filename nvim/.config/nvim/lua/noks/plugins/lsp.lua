return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      local config = {
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.INFO] = "◉",
            [vim.diagnostic.severity.WARN] = "",
          },
        },
        update_in_insert = true,
        underline = false,
        severity_sort = true,
        -- float = {
        -- 	focus = false,
        -- 	focusable = true,
        -- 	style = "minimal",
        -- 	border = "rounded",
        -- 	source = "always",
        -- 	header = "",
        -- 	prefix = "",
        -- },
        format_notify = false,
      }

      vim.diagnostic.config(config)

      -- Jump directly to the first available definition every time.
      vim.lsp.handlers["textDocument/definition"] = function(_, result)
        if not result or vim.tbl_isempty(result) then
          print("[LSP] Could not find definition")
          return
        end

        if vim.islist(result) then
          vim.lsp.util.jump_to_location(result[1], "utf-8")
        else
          vim.lsp.util.jump_to_location(result, "utf-8")
        end
      end

      -- Server configurations
      local servers = {
        sumneko = require("noks.lsp.servers.sumneko"),
        tsserver = require("noks.lsp.servers.tsserver"),
        go = require("noks.lsp.servers.go"),
        pyright = require("noks.lsp.servers.pyright"),
        jsonls = require("noks.lsp.servers.jsonls"),
      }

      -- Server specific configurations
      local configs = {
        jsonls = servers.jsonls,
        pyright = servers.pyright,
        sumneko_lua = servers.sumneko.config,
        tsserver = servers.tsserver.config,
        -- gopls = servers.go.settings,
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
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
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
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server_config = configs[server_name] or {}

            server_config.capabilities =
              vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})

            lspconfig[server_name].setup(server_config)
          end,
        },
      })
    end,
  },
}
