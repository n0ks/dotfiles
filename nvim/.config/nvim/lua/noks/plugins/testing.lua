---@diagnostic disable: missing-fields
return {

  "nvim-neotest/neotest-go",
  "haydenmeade/neotest-jest",
  "sidlatau/neotest-dart",
  "nvim-neotest/nvim-nio",
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    config = function()
      require("neotest").setup({
        quickfix = {
          enabled = false,
        },
        icons = {
          running = "",
          failed = "",
          passed = "👌",
        },
        log_level = vim.log.levels.DEBUG,
        output = {
          open_on_run = true
        },
        adapters = {
          require("neotest-jest")({
            jestCommand = "npx jest --",
            jestConfigFile = "jest.config.ts",
          }),
          require("neotest-dart")({
            command = "flutter",
            use_lsp = true,
            custom_test_method_names = { "group", "blocTest", "test", "testWidget" },
          }),
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
          }),
        },
      })
    end,
  },
}
