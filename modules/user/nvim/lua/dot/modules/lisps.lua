local M = {}

M.packages = {
  { 'Olical/aniseed' },
  { 'Olical/conjure', config = { vim.cmd([[let maplocalleader=","]]) } },
  { 'bakpakin/fennel.vim' },
  { 'janet-lang/janet.vim' },
}

return M
