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

-- Formatters that are safe to run unattended: they are either
-- project-config-free or driven by a config the repo already owns.
-- The prettier filetypes stay on <leader>fm, since a global prettier with
-- no project config would reformat to its own defaults on every save.
local format_on_save_filetypes = {
  go = true,
  dart = true,
  lua = true,
  sh = true,
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
      format_on_save = function(bufnr)
        if not format_on_save_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end
        if vim.api.nvim_buf_get_name(bufnr):find("/node_modules/", 1, true) then
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
          -- conform's default args are { "format", "$FILENAME" }; prepending
          -- here produced `dart -l 120 format ...`, which dart rejects, so
          -- dart formatting silently did nothing.
          args = { "format", "-l", "120", "$FILENAME" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      local eslint = { "eslint_d" }

      lint.linters_by_ft = {
        go = { "golangcilint" },
        javascript = eslint,
        javascriptreact = eslint,
        typescript = eslint,
        typescriptreact = eslint,
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      }

      -- try_lint() errors out loud when a linter's binary is missing, which
      -- turns every save in a repo without it into a message.
      local function lint_if_available()
        local names = lint.linters_by_ft[vim.bo.filetype]
        if not names then
          return
        end
        for _, name in ipairs(names) do
          local linter = lint.linters[name]
          local cmd = type(linter) == "table" and linter.cmd
          if type(cmd) == "string" and vim.fn.executable(cmd) == 1 then
            lint.try_lint(name)
          end
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = lint_if_available,
      })
    end,
  },
}
