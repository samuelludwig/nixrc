local M = {}

M.packages = {
  {
    'tjdevries/colorbuddy.vim',
    'tjdevries/gruvbuddy.nvim',
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
  { 'sainnhe/edge' },
  { 'sainnhe/everforest' },
  { 'sainnhe/gruvbox-material' },
  { 'Th3Whit3Wolf/space-nvim' },
  { 'Th3Whit3Wolf/onebuddy' },
  { 'jacoborus/tender.vim' },
  { 'owickstrom/vim-colors-paramount' },
  --use({ "rj-white/vim-colors-paramountblue" }) -- not real??
  { 'https://gitlab.com/yorickpeterse/vim-paper.git' },
  { 'huyvohcmc/atlas.vim' },
  { 'ray-x/aurora' },
  { 'tanvirtin/monokai.nvim' },
  { 'cseelus/vim-colors-lucid' },
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
  { 'kyazdani42/blue-moon' },
  { 'mhartington/oceanic-next' },
  { 'glepnir/zephyr-nvim' },
  { 'rockerBOO/boo-colorscheme-nvim', branch = 'main' },
  { 'bkegley/gloombuddy', requires = { 'tjdevries/colorbuddy.vim' } },
  { 'tomasiser/vim-code-dark' },
  { 'sts10/vim-pink-moon' },
  { 'shaunsingh/nord.nvim' },
  {
    'shaunsingh/moonlight.nvim',
    config = function()
      require('colorschemes.moonlight')
    end,
  },
  { 'kamwitsta/flatwhite-vim' },
  { 'navarasu/onedark.nvim' },
  {
    'ishan9299/nvim-solarized-lua',
    config = function()
      require('colorschemes.nvim-solarized-lua')
    end,
  },
}

return M
