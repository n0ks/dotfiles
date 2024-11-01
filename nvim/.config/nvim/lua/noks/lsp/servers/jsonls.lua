return {
 settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = {enabled = true },
    },
  },
  -- setup = {
  --   commands = {
  --     Format = {
  --       function()
  --         vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
  --       end,
  --     },
  --   },
  -- },
}
