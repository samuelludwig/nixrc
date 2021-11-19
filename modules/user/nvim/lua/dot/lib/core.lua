local nnoremap = function(bind, cmd)
      vim.api.nvim_set_keymap("n", bind, cmd, { noremap = true, silent = true })
end
local nmap = function(bind, cmd)
      vim.api.nvim_set_keymap("n", bind, cmd, { silent = true })
end
