local M = {}

M.packages = {
  -- { 'wbthomason/packer.nvim' },

  ---- vimwiki
  --{
  --  'vimwiki/vimwiki',
  --  --config = function() --setup doesnt work either...
  --  --  require('modules.vimwiki')
  --  --end
  --},

  --{
  --  'michal-h21/vim-zettel',
  --  requires = {
  --    'vimwiki/vimwiki',
  --    'junegunn/fzf',
  --    'junegunn/fzf.vim',
  --  },
  --  config = function()
  --    vim.g.zettel_fzf_command = 'rg --column --line-number --ignore-case --no-heading --color=always '
  --    vim.g.nv_search_paths = { '~/vimwiki' }
  --    --- TITLES ---
  --    -- Change timestamp format to a 4-digit year
  --    --vim.g.zettel_format = "%Y%m%d%H%M-%title"

  --    -- Change timestamp format to a 4-digit year and use ID-only for filenames
  --    vim.g.zettel_format = '%Y%m%d%H%M'
  --  end,
  --},

  --{
  --  'ElPiloto/telescope-vimwiki.nvim',
  --  enable = false,
  --  requires = {
  --    'vimwiki/vimwiki',
  --    'nvim-telescope/telescope.nvim',
  --  },
  --  config = function()
  --    require('telescope').load_extension('vw')
  --    --nmap("<leader>vw", require("telescope").extensions.vw.vw())
  --    --nmap("<leader>vg", require("telescope").extensions.vw.live_grep())
  --  end,
  --},

  -- {
  --   'tpope/vim-commentary',
  --   'tpope/vim-fugitive',
  --   'tpope/vim-abolish',
  --   'tpope/vim-surround',
  -- },

  -- {
  --   'nvim-lua/popup.nvim',
  --   'nvim-lua/plenary.nvim',
  -- },

--   {
--     'kristijanhusak/orgmode.nvim',
--     config = function()
--       require('orgmode').setup({
--         org_agenda_files = { '~/Dropbox/org/*' },
--         org_default_notes_file = '~/Dropbox/notes.org',
--       })
--     end,
--   },

--   {
--     'LnL7/vim-nix',
--     ft = { 'nix' },
--   },

  -- {
  --   'NTBBloodbath/galaxyline.nvim',
  --   config = function()
  --     require('modules.galaxyline')
  --   end,
  -- },

  --
  -- COLORSCHEMES
  --

  --{
  --  'tjdevries/colorbuddy.vim',
  --  'tjdevries/gruvbuddy.nvim',
  --},
  --{
  --  'jacksonludwig/vim-earl-grey',
  --  requires = { 'rktjmp/lush.nvim' },
  --  -- config = function()
  --  --   vim.cmd("colorscheme vim-earl-grey")
  --  --   vim.cmd([[
  --  --      hi StatusLine gui=NONE
  --  --      hi StatusLine guibg=NONE
  --  --      hi StatusLineNC guibg=NONE
  --  --      hi StatusLineNC gui=NONE
  --  --   ]])
  --  -- end,
  --},
  --{ 'sainnhe/sonokai' }, -- Settings found in `:help sonokai`
  --{ 'sainnhe/edge' },
  --{ 'sainnhe/everforest' },
  --{ 'sainnhe/gruvbox-material' },
  --{ 'Th3Whit3Wolf/space-nvim' },
  --{ 'Th3Whit3Wolf/onebuddy' },
  --{ 'jacoborus/tender.vim' },
  --{ 'owickstrom/vim-colors-paramount' },
  ----use({ "rj-white/vim-colors-paramountblue" }) -- not real??
  --{ 'https://gitlab.com/yorickpeterse/vim-paper.git' },
  --{ 'huyvohcmc/atlas.vim' },
  --{ 'ray-x/aurora' },
  --{ 'tanvirtin/monokai.nvim' },
  --{ 'cseelus/vim-colors-lucid' },
  --{
  --  'maaslalani/nordbuddy',
  --  config = function()
  --    vim.g.nord_underline_option = 'none'
  --    vim.g.nord_italic = true
  --    vim.g.nord_italic_comments = false
  --    vim.g.nord_minimal_mode = false
  --    --require('nordbuddy').colorscheme(
  --    -- This function takes a table as argument.
  --    -- If an empty table is passed, these values are implicitly assigned.
  --    --{
  --    -- Underline style used for spelling
  --    -- Options: 'none', 'underline', 'undercurl'
  --    --underline_option = 'none',

  --    -- Italics for certain keywords such as constructors, functions,
  --    -- labels and namespaces
  --    --italic = true,

  --    -- Italic styled comments
  --    --italic_comments = false,

  --    -- Minimal mode: different choice of colors for Tabs and StatusLine
  --    --minimal_mode = false
  --    --})
  --  end,
  --},
  --{ 'kyazdani42/blue-moon' },
  --{ 'mhartington/oceanic-next' },
  --{ 'glepnir/zephyr-nvim' },
  --{ 'rockerBOO/boo-colorscheme-nvim', branch = 'main' },
  --{ 'bkegley/gloombuddy', requires = { 'tjdevries/colorbuddy.vim' } },
  --{ 'tomasiser/vim-code-dark' },
  --{ 'sts10/vim-pink-moon' },
  --{ 'shaunsingh/nord.nvim' },
  --{
  --  'shaunsingh/moonlight.nvim',
  --  config = function()
  --    require('colorschemes.moonlight')
  --  end,
  --},
  --{ 'kamwitsta/flatwhite-vim' },
  --{ 'navarasu/onedark.nvim' },
  --{
  --  'ishan9299/nvim-solarized-lua',
  --  config = function()
  --    require('colorschemes.nvim-solarized-lua')
  --  end,
  --},

  ----
  ---- TELESCOPE
  ----

  --{
  --  'nvim-telescope/telescope.nvim',
  --  requires = { 'nvim-telescope/telescope-fzf-native.nvim' },
  --  config = function()
  --    require('modules.telescope')
  --  end,
  --},

  -- {
  --   'ahmedkhalf/project.nvim',
  --   config = function()
  --     require('project_nvim').setup({})
  --   end,
  -- },

  -- {
  --   'nvim-treesitter/nvim-treesitter',
  --   config = function()
  --     require('nvim-treesitter.configs').setup({
  --       highlight = {
  --         enable = true,
  --       },
  --       indent = { enable = true },
  --     })
  --   end,
  -- },

  -- {
  --   'neovim/nvim-lspconfig',
  --   requires = {
  --     'jose-elias-alvarez/nvim-lsp-ts-utils',
  --     'jose-elias-alvarez/null-ls.nvim',
  --   },
  --   config = function()
  --     require('modules.nvim-lspconfig')
  --   end,
  -- },

  -- {
  --   'L3MON4D3/LuaSnip',
  --   requires = { 'rafamadriz/friendly-snippets' },
  --   config = function()
  --     require('luasnip.loaders.from_vscode').load()
  --     vim.cmd([[
  --       imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
  --       inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
  --       snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
  --       snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
  --     ]])
  --   end,
  -- },

  -- {
  --   'hrsh7th/nvim-cmp',
  --   requires = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'saadparwaiz1/cmp_luasnip' },
  --   config = function()
  --     local cmp = require('cmp')
  --     cmp.setup({
  --       completion = {
  --         autocomplete = false,
  --       },
  --       snippet = {
  --         expand = function(args)
  --           require('luasnip').lsp_expand(args.body)
  --         end,
  --       },
  --       mapping = {
  --         ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --       },
  --       sources = {
  --         { name = 'nvim_lsp' },
  --         { name = 'buffer' },
  --         { name = 'luasnip' },
  --       },
  --     })
  --   end,
  -- },
-- }

M.config = function()
  -- what?
  -- vim.cmd([[
  --   nnoremap <leader>vw <cmd>lua require('telescope').extensions.vw.vw()<cr>
  --   nnoremap <leader>vg <cmd>lua require('telescope').extensions.vw.live_grep()<cr>
  -- ]])

  -- Configs for vimwiki, it breakes when its included in either config or
  -- setup, but whyyyy???
  -- require('modules.vimwiki')
end
return M
