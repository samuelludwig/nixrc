local telescope = require("telescope")

telescope.setup({
  pickers = {
    find_files = { disable_devicons = true, theme = "ivy" },
    buffers = { disable_devicons = true, theme = "ivy" },
    oldfiles = { disable_devicons = true, theme = "ivy" },
    grep_string = { disable_devicons = true, theme = "ivy" },
    live_grep = { disable_devicons = true, theme = "ivy" },
    file_browser = { disable_devicons = true, theme = "ivy" },
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

vim.api.nvim_set_keymap(
  "n",
  "<leader><leader>",
  "<cmd>lua require('telescope.builtin').find_files()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fh",
  "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fr",
  "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fi",
  "<cmd>lua require('telescope.builtin').live_grep({ cwd = '~/vimwiki' })<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>bb",
  "<cmd>lua require('telescope.builtin').buffers()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>g",
  "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ff",
  "<cmd>lua require('telescope.builtin').file_browser()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>vc",
  "<cmd>lua require('telescope.builtin').git_commits()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>vb",
  "<cmd>lua require('telescope.builtin').git_branches()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sdd",
  "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sdw",
  "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>",
  { noremap = true, silent = true }
)
