local prettier_filetypes = {
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
  "jsonc",
  "yaml",
  "markdown",
  "graphql",
}

local formatters_by_ft = {
  go = { "goimports-reviser", "gofumpt", "golines" },
  dart = { "dart_format" },
  lua = { "stylua" },
  sh = { "shfmt" },
}

for _, ft in ipairs(prettier_filetypes) do
  formatters_by_ft[ft] = { "prettier" }
end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = formatters_by_ft,
      -- Matches the previous `BufWritePre *.go` autocmd; everything else is
      -- formatted on demand via <leader>fm.
      format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype ~= "go" then
          return nil
        end
        return { timeout_ms = 5000, lsp_format = "fallback" }
      end,
      formatters = {
        ["goimports-reviser"] = {
          prepend_args = { "-rm-unused" },
        },
        golines = {
          prepend_args = { "--max-len=180", "--base-formatter=gofumpt" },
        },
        dart_format = {
          prepend_args = { "-l", "120" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangcilint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
