return {
  enabled = false,
  "pmizio/typescript-tools.nvim",
  dependencies = { "dmmulroy/ts-error-translator.nvim" },
  -- config = function()
  --   local api = require("typescript-tools.api")
  --   require("typescript-tools").setup({
  --     handlers = {
  --       ["textDocument/publishDiagnostics"] = api.filter_diagnostics(
  -- Ignore 'This may be converted to an async function' diagnostics.
  --           { 80006 }
  --         ),
  --       },
  --       settings = {
  --         jsx_close_tag = {
  --           enable = true,
  --           filetypes = { "javascriptreact", "typescriptreact" },
  --         },
  --       },
  --     })
  --   end,
}
