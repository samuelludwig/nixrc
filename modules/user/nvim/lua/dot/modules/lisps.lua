local M = {}

M.packages = {
  { 'Olical/aniseed' },
  {
    'Olical/conjure',
    config = function()
      vim.cmd([[let maplocalleader=","]])
    end,
  },
  { 'bakpakin/fennel.vim' },
  { 'janet-lang/janet.vim' },
}

return M
