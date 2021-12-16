local u = require('lib.utils')

local M = {}

M.packages = {
  { 'huyvohcmc/atlas.vim' },
  { 'ray-x/aurora' },
  { 'kyazdani42/blue-moon' },
  { 'rockerBOO/boo-colorscheme-nvim', branch = 'main' },
  {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require('colorschemes.catppuccin')
    end,
  },
  { 'tjdevries/colorbuddy.vim' },
  { 'sainnhe/edge' },
  { 'sainnhe/everforest' },
  { 'kamwitsta/flatwhite-vim' },
  { 'bkegley/gloombuddy', requires = { 'tjdevries/colorbuddy.vim' } },
  { 'sainnhe/gruvbox-material' },
  { 'tjdevries/gruvbuddy.nvim', requires = 'tjdevries/colorbuddy.vim' },
  { 'katawful/kat.nvim' },
  { 'tanvirtin/monokai.nvim' },
  {
    'shaunsingh/moonlight.nvim',
    config = function()
      require('colorschemes.moonlight')
    end,
  },
  {
    'maaslalani/nordbuddy',
    config = function()
      vim.g.nord_underline_option = 'none'
      vim.g.nord_italic = true
      vim.g.nord_italic_comments = false
      vim.g.nord_minimal_mode = false
      --require('nordbuddy').colorscheme(
      -- This function takes a table as argument.
      -- If an empty table is passed, these values are implicitly assigned.
      --{
      -- Underline style used for spelling
      -- Options: 'none', 'underline', 'undercurl'
      --underline_option = 'none',

      -- Italics for certain keywords such as constructors, functions,
      -- labels and namespaces
      --italic = true,

      -- Italic styled comments
      --italic_comments = false,

      -- Minimal mode: different choice of colors for Tabs and StatusLine
      --minimal_mode = false
      --})
    end,
  },
  { 'shaunsingh/nord.nvim' },
  {
    'ishan9299/nvim-solarized-lua',
    config = function()
      require('colorschemes.nvim-solarized-lua')
    end,
  },
  {
    'jacksonludwig/vim-earl-grey',
    requires = { 'rktjmp/lush.nvim' },
    -- config = function()
    --   vim.cmd("colorscheme vim-earl-grey")
    --   vim.cmd([[
    --      hi StatusLine gui=NONE
    --      hi StatusLine guibg=NONE
    --      hi StatusLineNC guibg=NONE
    --      hi StatusLineNC gui=NONE
    --   ]])
    -- end,
  },
  { 'sainnhe/sonokai' }, -- Settings found in `:help sonokai`
  { 'Th3Whit3Wolf/space-nvim' },
  { 'Th3Whit3Wolf/onebuddy' },
  { 'jacoborus/tender.vim' },
  { 'owickstrom/vim-colors-paramount' },
  --use({ "rj-white/vim-colors-paramountblue" }) -- not real??
  { 'https://gitlab.com/yorickpeterse/vim-paper.git' },
  { 'cseelus/vim-colors-lucid' },
  { 'mhartington/oceanic-next' },
  { 'glepnir/zephyr-nvim' },
  { 'tomasiser/vim-code-dark' },
  { 'sts10/vim-pink-moon' },
  { 'navarasu/onedark.nvim' },
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'storm'
      --vim.g.tokyonight_style = 'dark'
      --vim.g.tokyonight_style = 'day'
    end,
  },
  {
    'mcchrish/zenbones.nvim',
    requires = { 'rktjmp/lush.nvim' },
  },
}

--
-- CONFIG
--

M.config = function()
  u.nnoremap('<leader>b', [[<Cmd>lua require('modules.themes').exports.toggle_background()<CR>]])
  u.nnoremap('<leader>cs', [[:colorscheme ]])
end

--
-- EXPORTS
--

local set_bg = function(color)
  vim.o.background = color
end

M.exports = {
  toggle_background = function()
    if vim.o.background == 'dark' then
      set_bg('light')
    else
      set_bg('dark')
    end
  end,
}

return M
