local M = {}

M.settings = {
	pyright = {
		disableOrganizeImports = false,
		analysis = {
			useLibraryCodeForTypes = true,
			autoSearchPaths = true,
			diagnosticMode = "workspace",
			autoImportCompletions = true,
		},
	},
}

return M
