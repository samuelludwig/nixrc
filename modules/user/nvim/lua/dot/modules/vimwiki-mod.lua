local M = {}

M.packages = {
  {
    'vimwiki/vimwiki',
    --config = function() --setup doesnt work either...
    --  require('modules.vimwiki')
    --end
  },
  {
    'michal-h21/vim-zettel',
    requires = {
      'vimwiki/vimwiki',
      'junegunn/fzf',
      'junegunn/fzf.vim',
    },
    config = function()
      vim.g.zettel_fzf_command = 'rg --column --line-number --ignore-case --no-heading --color=always '
      vim.g.nv_search_paths = { '~/vimwiki' }
      --- TITLES ---
      -- Change timestamp format to a 4-digit year
      --vim.g.zettel_format = "%Y%m%d%H%M-%title"

      -- Change timestamp format to a 4-digit year and use ID-only for filenames
      vim.g.zettel_format = '%Y%m%d%H%M'
    end,
  },
  {
    'ElPiloto/telescope-vimwiki.nvim',
    enable = false,
    requires = {
      'vimwiki/vimwiki',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('telescope').load_extension('vw')

      -- what?
      vim.cmd([[
        nnoremap <leader>vw <cmd>lua require('telescope').extensions.vw.vw()<cr>
        nnoremap <leader>vg <cmd>lua require('telescope').extensions.vw.live_grep()<cr>
      ]])
    end,
  },
}

M.config = function()
  local nmap = function(bind, cmd)
    vim.api.nvim_set_keymap('n', bind, cmd, { silent = true })
  end

  -- Autopopulate the header of every new vimwiki file
  vim.g.vimwiki_auto_header = 1
  vim.g.vimwiki_list = { { path = '~/vimwiki' } }
  -- Convenient splits
  nmap('<Leader>we', '<Plug>VimwikiSplitLink')
  nmap('<Leader>wq', '<Plug>VimwikiVSplitLink')
  -- Easy access to my buffer file
  nmap('<Leader>c', ':split ~/vimwiki/Buffer.wiki<Enter>')
end

return M
