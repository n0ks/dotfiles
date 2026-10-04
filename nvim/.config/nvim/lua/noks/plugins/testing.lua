---@diagnostic disable: missing-fields
return {

  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "fredrikaverpil/neotest-golang",
      "haydenmeade/neotest-jest",
      "sidlatau/neotest-dart",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
    },
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
        log_level = vim.log.levels.WARN,
        output = {
          open_on_run = true,
        },
        adapters = {
          require("neotest-jest")({
            jestCommand = "npx jest --",
            -- Hardcoding jest.config.ts broke every repo using another
            -- extension; resolve it upward from the test file instead.
            jestConfigFile = function(file)
              local found = vim.fs.find({
                "jest.config.ts",
                "jest.config.js",
                "jest.config.mjs",
                "jest.config.cjs",
                "jest.config.json",
              }, { upward = true, path = vim.fs.dirname(file) })
              return found[1]
            end,
          }),
          require("neotest-dart")({
            command = "flutter",
            use_lsp = true,
            custom_test_method_names = { "group", "blocTest", "test", "testWidget" },
          }),
          -- neotest-go has been unmaintained since 2024-05.
          require("neotest-golang")({}),
        },
      })
    end,
  },
}
