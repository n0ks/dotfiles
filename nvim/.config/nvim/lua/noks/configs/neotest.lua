require("neotest").setup({
  icons = {
    running = "",
  },
  adapters = {
    require("neotest-jest")({
      jestCommand = "npx jest --",
      jestConfigFile = "jest.config.ts",
    }),
  },
})
