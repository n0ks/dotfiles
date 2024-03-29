local M = {}

_G.lsp_organize_imports = function()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

M.merge = function(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
	return t1
end

M._if = function(bool, a, b)
	if bool then
		return a
	else
		return b
	end
end

M.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", opts, options)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

M.foreach = function(fn, list)
	for key, value in pairs(list) do
		fn(value, key)
	end
end

return M
