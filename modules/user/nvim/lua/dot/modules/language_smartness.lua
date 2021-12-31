local M = {}

M.packages = {
  {
    'LnL7/vim-nix',
    ft = { 'nix' },
  },
  {
    'vmchale/dhall-vim',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
        },
        indent = { enable = true },
      })
    end,
  },

  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({})
    end,
  },

  {
    'neovim/nvim-lspconfig',
    requires = {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('modules.nvim-lspconfig')
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    requires = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip.loaders.from_vscode').load()
      vim.cmd([[
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      ]])
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'saadparwaiz1/cmp_luasnip' },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        completion = {
          autocomplete = false,
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'luasnip' },
        },
      })
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end,
  },
}

return M
