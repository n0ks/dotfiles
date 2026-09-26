local M = {}

-- Merge two tables (shallow merge)
M.merge = function(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

-- Ternary operator helper
M._if = function(bool, a, b)
  if bool then
    return a
  else
    return b
  end
end

-- Wrapper for vim.keymap.set with default options
-- `remap = true` opts out of the forced `noremap`, which is required for any
-- rhs that has to expand another mapping (e.g. a `<Plug>` target).
M.map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  local options = { silent = true }
  if not opts.remap then
    options.noremap = true
  end
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", options, opts))
end

-- Iterate over a table and apply a function to each element
M.foreach = function(fn, list)
  for key, value in pairs(list) do
    fn(value, key)
  end
end

return M
