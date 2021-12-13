local M = {}

M.packages = {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
    end,
  },
}

return M
