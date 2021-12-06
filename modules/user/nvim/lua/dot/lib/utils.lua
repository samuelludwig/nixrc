local M = {}

local knoremap = function(mode, bind, cmd)
  vim.api.nvim_set_keymap(mode, bind, cmd, { noremap = true, silent = true })
end
M.knoremap = knoremap

local kmap = function(mode, bind, cmd)
  vim.api.nvim_set_keymap(mode, bind, cmd, { silent = true })
end
M.kmap = kmap

local nnoremap = function(bind, cmd)
  knoremap("n", bind, cmd)
end
M.nnoremap = nnoremap

local nmap = function(bind, cmd)
  kmap("n", bind, cmd)
end
M.nmap = nmap

return M
