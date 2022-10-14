require("neotest").setup({
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
		}),
		require("neotest-go")({
			experimental = {
				test_table = true,
			},
		}),
	},
})
