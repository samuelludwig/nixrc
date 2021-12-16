local u = require('lib.utils')

local M = {}

telescope_config = function()
  local telescope = require('telescope')

  telescope.setup({
    pickers = {
      find_files = { disable_devicons = true, theme = 'ivy' },
      buffers = { disable_devicons = true, theme = 'ivy' },
      oldfiles = { disable_devicons = true, theme = 'ivy' },
      grep_string = { disable_devicons = true, theme = 'ivy' },
      live_grep = { disable_devicons = true, theme = 'ivy' },
      file_browser = { disable_devicons = true, theme = 'ivy' },
    },
    --       extensions = {
    --         fzf = {
    --           override_generic_sorter = true, -- override the generic sorter
    --           override_file_sorter = true, -- override the file sorter
    --           case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    --         },
    --       },
  })

  --     telescope.load_extension("fzf")

  u.nnoremap('<leader><leader>', "<cmd>lua require('telescope.builtin').find_files()<cr>")
  u.nnoremap('<leader>fh', "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>")
  u.nnoremap('<leader>fr', "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
  u.nnoremap('<leader>fi', "<cmd>lua require('telescope.builtin').live_grep({ cwd = '~/vimwiki' })<cr>")
  u.nnoremap('<leader>bb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
  u.nnoremap('<leader>g', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
  u.nnoremap('<leader>ff', "<cmd>lua require('telescope.builtin').file_browser()<cr>")
  u.nnoremap('<leader>vc', "<cmd>lua require('telescope.builtin').git_commits()<cr>")
  u.nnoremap('<leader>vb', "<cmd>lua require('telescope.builtin').git_branches()<cr>")
  u.nnoremap('<leader>sdd', "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>")
  u.nnoremap('<leader>sdw', "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>")
end

M.packages = {
  'nvim-telescope/telescope.nvim',
  requires = { 'nvim-telescope/telescope-fzf-native.nvim' },
  config = function()
    telescope_config()
  end,
}

return M
