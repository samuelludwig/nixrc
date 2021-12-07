require("plugins")
local u = require("lib.utils")
local f = require("lib.fun")
--local module = require("lib.module")

-- general settings
local opt = vim.opt

opt.termguicolors = true
opt.undofile = true
opt.hidden = true
opt.splitright = true
opt.splitbelow = true
opt.wrap = false
opt.signcolumn = "yes"
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.completeopt = { "menuone", "noselect" }
opt.foldenable = false
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"
-- Cursor
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

vim.cmd([[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])

-- mappings
vim.g.mapleader = " "
u.nnoremap("<esc>", "<cmd>noh<CR>")
u.nnoremap("<leader>lo", "<cmd>copen<CR>")
u.nnoremap("<leader>lc", "<cmd>cclose<CR>")
u.nnoremap("<c-j>", "<cmd>cnext<CR>")
u.nnoremap("<c-k>", "<cmd>cprev<CR>")
u.nnoremap("<leader>n", [[<cmd>set nu! rnu!<CR>]])

vim.cmd([[
augroup Terminal
  autocmd!
  au TermOpen * setlocal nonu nornu signcolumn=no | startinsert
augroup end
]])

--require("colorbuddy").colorscheme("gruvbuddy")
vim.cmd('colorscheme paper')
vim.cmd([[
  hi MatchParen gui=underline
  hi StatusLine guibg=NONE
  hi StatusLine guifg=NONE
  hi StatusLineNC guibg=NONE
  hi VertSplit guifg=bg
  hi VertSplit guibg=darkgrey
]])
