require("neotest").setup({
  quickfix = {
    enabled = false,
  },
  icons = {
    running = "",
    failed = "",
    passed = "👌",
  },
  adapters = {
    require("neotest-jest")({
      jestCommand = "npx jest --",
      jestConfigFile = "jest.config.ts",
    }),
    require("neotest-dart")({
      command = "flutter",
      use_lsp = true,
    }),
    require("neotest-go")({
      experimental = {
        test_table = true,
      },
    }),
  },
})
