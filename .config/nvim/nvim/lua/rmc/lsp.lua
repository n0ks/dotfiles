-- local nvim_lsp = require('lspconfig')

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- local closing_labels_namespace = vim.api.nvim_create_namespace('dart_closing_labels')

-- local on_code_action = function (...)
--   local arg = {...}
--   print(vim.inspect(arg))
-- end

-- local on_closing_labels = function (...)
--   local arg = {...}
--   local labels = arg[3].labels

--   vim.api.nvim_buf_clear_namespace(0, closing_labels_namespace, 0, -1)

--   for i,l in ipairs(labels) do
--     local name =  l.label
--     local line = l.range['end'].line
--     vim.api.nvim_buf_set_virtual_text(
--       0,
--       closing_labels_namespace,
--       line,
--       {{'// '..name, 'Comment'}},
--       {}
--     )
--     print(i, name, line)
--   end
-- end

  -- nvim_lsp.dartls.setup{
  --   cmd = { "dart", "~/fvm/default/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
  --   on_attach = require('completion').on_attach(),
  --   init_options = {
  --     closingLabels = true,
  --     flutterOutline = true,
  --     onlyAnalyzeProjectsWithOpenFiles = true,
  --     suggestFromUnimkortedLibraries = true,
  --     outline = true,
  --   },
  --     callbacks = {
  --     ['dart/textDocument/publishClosingLabels'] = on_closing_labels;
  --     ['textDocument/codeAction'] = on_code_action;
  --   };

  -- }

-- require'lspinstall'.setup() -- important

-- local servers = require'lspinstall'.installed_servers()
-- for _, server in pairs(servers) do
--   require'lspconfig'[server].setup{}
-- end

