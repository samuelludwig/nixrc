local M = {}

M.nnoremap = function(bind, cmd)
  vim.api.nvim_set_keymap("n", bind, cmd, { noremap = true, silent = true })
  return ':ok'
end

M.nmap = function(bind, cmd)
  vim.api.nvim_set_keymap("n", bind, cmd, { silent = true })
  return ':ok'
end

return M
