local path = require("nvim-lsp-installer.path")
local install_root_dir = path.concat({ vim.fn.stdpath("data"), "lsp_servers" })

local M = {}

M.setup = function()
	require("go").setup({
		gopls_cmd = { install_root_dir .. "/go/gopls" },
		filstruct = "gopls",
		dap_debug = true,
		dap_debug_gui = true,
	})
end

return M
