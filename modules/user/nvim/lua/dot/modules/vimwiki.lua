local nmap = function(bind, cmd)
      vim.api.nvim_set_keymap("n", bind, cmd, { silent = true })
end

-- Autopopulate the header of every new vimwiki file
vim.g.vimwiki_auto_header = 1
vim.g.vimwiki_list = { { path = '~/vimwiki' } }
-- Convenient splits
nmap("<Leader>we", "<Plug>VimwikiSplitLink")
nmap("<Leader>wq", "<Plug>VimwikiVSplitLink")
-- Easy access to my buffer file
nmap("<Leader>c", ":split ~/vimwiki/Buffer.wiki<Enter>")
