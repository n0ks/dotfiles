return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = { winblend = 0 },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
      "folke/lazydev.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
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
        update_in_insert = false,
        underline = { severity = vim.diagnostic.severity.ERROR },
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
        lua_ls = require("noks.lsp.servers.lua_ls"),
        yamlls = require("noks.lsp.servers.yamlls"),
        jsonls = require("noks.lsp.servers.jsonls"),
        gopls = require("noks.lsp.servers.gopls"),
        ts_ls = require("noks.lsp.servers.ts_ls"),
        mpls = {},
      }

      local highlight_method = vim.lsp.protocol.Methods.textDocument_documentHighlight
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

      -- One global detach handler. Recreating it with clear=true inside
      -- LspAttach dropped the previous buffer's cleanup, and clearing
      -- highlights on any detach killed them while another client still
      -- wanted documentHighlight.
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event)
          pcall(vim.api.nvim_buf_call, event.buf, vim.lsp.buf.clear_references)
          local remaining = vim.lsp.get_clients({
            bufnr = event.buf,
            method = highlight_method,
          })
          local detaching_id = event.data and event.data.client_id
          local still = vim.tbl_filter(function(client)
            return client.id ~= detaching_id
          end, remaining)
          if #still == 0 then
            vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event.buf })
          end
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end

          vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })

          if not client:supports_method(highlight_method, event.buf) then
            return
          end

          -- Replace, don't stack, when a second client attaches to the buffer.
          vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event.buf })
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
        end,
      })

      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
      end

      local server_names = vim.tbl_keys(servers)
      require("mason-lspconfig").setup({
        ensure_installed = server_names,
        -- Default automatic_enable=true would vim.lsp.enable() every Mason
        -- server, including a stray dartls that would double-attach with
        -- flutter-tools.
        automatic_enable = server_names,
      })
    end,
  },
}
