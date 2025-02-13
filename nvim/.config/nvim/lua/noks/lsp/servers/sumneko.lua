return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = { "vim" },
        disable = { "missing-fields" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
