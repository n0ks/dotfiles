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

M.map = function(modes, key, result, options)
	options = M.merge({
		noremap = true,
		silent = false,
		expr = false,
		nowait = false,
	}, options or {})
	local buffer = options.buffer
	options.buffer = nil

	if type(modes) ~= "table" then
		modes = { modes }
	end

	for i = 1, #modes do
		if buffer then
			vim.api.nvim_buf_set_keymap(0, modes[i], key, result, options)
		else
			vim.api.nvim_set_keymap(modes[i], key, result, options)
		end
	end
end

return M
