return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        -- lazydev.nvim supplies the real vim API library; this is a fallback
        -- for buffers that attach before it has loaded.
        globals = { "vim" },
        disable = { "missing-fields" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
