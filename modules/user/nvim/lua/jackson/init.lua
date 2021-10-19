-- packer bootstrap
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

-- packer
local packer = require("packer")
local use = packer.use

packer.startup(function()
  use({
    "wbthomason/packer.nvim",
  })

  use({
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "tpope/vim-abolish",
    "tpope/vim-surround",
  })

  use({
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
  })

  use({
    "kristijanhusak/orgmode.nvim",
    config = function()
      require("orgmode").setup({
        org_agenda_files = { "~/Dropbox/org/*" },
        org_default_notes_file = "~/Dropbox/notes.org",
      })
    end,
  })

  use({
    "LnL7/vim-nix",
    ft = { "nix" },
  })

  use({
    "NTBBloodbath/galaxyline.nvim",
    config = function()
      local gl = require("galaxyline")
      local condition = require("galaxyline.condition")
      local gls = gl.section
      gl.short_line_list = { "NvimTree", "vista_kind", "dbui" }

      local custom_filename_sect = {
        provider = function()
          local filename = vim.fn.expand("%:@")

          return filename == "" and "[No Name]" or filename
        end,
        separator = " ",
      }

      gls.left[1] = {
        FileIcon = {
          provider = function()
            local ft = vim.bo.filetype
            return "[" .. (ft ~= "" and ft or "none") .. "]"
          end,
          condition = condition.buffer_not_empty,
          highlight = "Comment",
          separator = " ",
        },
      }
      gls.left[2] = {
        CustomBufferFilename = custom_filename_sect,
      }
      gls.left[3] = {
        FileStatus = {
          provider = function()
            if vim.bo.readonly == true then
              if vim.bo.filetype == "help" then
                return "[H] "
              else
                return "[RO] "
              end
            end

            if vim.bo.modifiable and vim.bo.modified then
              return "[+] "
            end

            return ""
          end,
          highlight = "Identifier",
        },
      }
      gls.left[4] = {
        LineInfo = {
          provider = function()
            local line = vim.fn.line(".")
            local column = vim.fn.col(".")
            return string.format("%d:%d ", line, column)
          end,
          condition = condition.buffer_not_empty,
        },
      }
      gls.left[5] = {
        LinePercent = {
          provider = "LinePercent",
          condition = condition.buffer_not_empty,
        },
      }

      gls.right[1] = {
        DiagnosticError = {
          provider = "DiagnosticError",
          icon = "E",
          highlight = "DiagnosticError",
        },
      }
      gls.right[2] = {
        DiagnosticWarn = {
          provider = "DiagnosticWarn",
          icon = "W",
          highlight = "DiagnosticWarn",
        },
      }
      gls.right[3] = {
        DiagnosticHint = {
          provider = "DiagnosticHint",
          icon = "H",
          highlight = "DiagnosticHint",
        },
      }
      gls.right[4] = {
        DiagnosticInfo = {
          provider = "DiagnosticInfo",
          icon = "I",
          highlight = "DiagnosticInfo",
        },
      }
      gls.right[5] = {
        lsp_status = {
          provider = function()
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.buf_get_clients(bufnr)
            local clientnames_tbl = {}

            for _, v in pairs(clients) do
              if v.name then
                table.insert(clientnames_tbl, v.name)
              end
            end

            if #clientnames_tbl ~= 0 then
              return "lsp:" .. table.concat(clientnames_tbl, "/")
            end

            return ""
          end,
          highlight = "Comment",
        },
      }
      gls.right[6] = {
        GitIcon = {
          provider = function()
            return "git:"
          end,
          separator = " ",
          condition = condition.check_git_workspace,
          highlight = "Comment",
        },
      }
      gls.right[7] = {
        GitBranch = {
          provider = "GitBranch",
          condition = condition.check_git_workspace,
          highlight = "Comment",
        },
      }

      gls.short_line_left[1] = {
        CustomBufferFilename = custom_filename_sect,
      }
    end,
  })

  use({
    "tjdevries/colorbuddy.vim",
    "tjdevries/gruvbuddy.nvim",
  })

  use({
    "~/git_repos/vim-earl-grey",
    requires = { "rktjmp/lush.nvim" },
    -- config = function()
    --   vim.cmd("colorscheme vim-earl-grey")
    --   vim.cmd([[
    --      hi StatusLine gui=NONE
    --      hi StatusLine guibg=NONE
    --      hi StatusLineNC guibg=NONE
    --      hi StatusLineNC gui=NONE
    --   ]])
    -- end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        pickers = {
          find_files = { disable_devicons = true },
          buffers = { disable_devicons = true },
          oldfiles = { disable_devicons = true },
          grep_string = { disable_devicons = true },
          live_grep = { disable_devicons = true },
          file_browser = { disable_devicons = true },
        },
        extensions = {
          fzf = {
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
        },
      })

      telescope.load_extension("fzf")

      vim.api.nvim_set_keymap(
        "n",
        "<leader><leader>",
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>fh",
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({ hidden = true }))<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>fr",
        "<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>bb",
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>g",
        "<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ff",
        "<cmd>lua require('telescope.builtin').file_browser(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>vc",
        "<cmd>lua require('telescope.builtin').git_commits(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>vb",
        "<cmd>lua require('telescope.builtin').git_branches(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sdd",
        "<cmd>lua require('telescope.builtin').lsp_document_diagnostics(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sdw",
        "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics(require('telescope.themes').get_ivy())<cr>",
        { noremap = true, silent = true }
      )
    end,
  })

  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
      })
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    requires = {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      local nvim_lsp = require("lspconfig")

      local on_attach_common = function(client, bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        local opts = { noremap = true, silent = true }

        -- usually not using lsp to format
        client.resolved_capabilities.document_formatting = false

        buf_set_keymap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
        buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
      end

      -- TYPESCRIPT/TSX SLOW HIGHLIGHT HACK
      local TSPrebuild = {}
      local has_prebuilt = false

      TSPrebuild.on_attach = function(_, _)
        if has_prebuilt then
          return
        end

        local query = require("vim.treesitter.query")

        local function safe_read(filename, read_quantifier)
          local file, err = io.open(filename, "r")
          if not file then
            error(err)
          end
          local content = file:read(read_quantifier)
          io.close(file)
          return content
        end

        local function read_query_files(filenames)
          local contents = {}

          for _, filename in ipairs(filenames) do
            table.insert(contents, safe_read(filename, "*a"))
          end

          return table.concat(contents, "")
        end

        local function prebuild_query(lang, query_name)
          local query_files = query.get_query_files(lang, query_name)
          local query_string = read_query_files(query_files)

          query.set_query(lang, query_name, query_string)
        end

        local prebuild_languages = { "typescript", "javascript", "tsx" }
        for _, lang in ipairs(prebuild_languages) do
          prebuild_query(lang, "highlights")
          prebuild_query(lang, "injections")
        end

        has_prebuilt = true
      end

      local common_capabilities = vim.lsp.protocol.make_client_capabilities()
      common_capabilities = require("cmp_nvim_lsp").update_capabilities(common_capabilities)

      local null_ls = require("null-ls")
      null_ls.config({
        save_after_format = false,
        sources = {
          -- eslint_d/js/jsx/ts/tsx handled by nvim_ts_utils
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "yaml", "json", "html", "css" },
          }),
          null_ls.builtins.formatting.stylua.with({
            filetypes = { "lua" },
          }),
          null_ls.builtins.formatting.nixfmt.with({
            filetypes = { "nix" },
          }),
          null_ls.builtins.formatting.black.with({
            filetypes = { "python" },
          }),
          null_ls.builtins.formatting.isort.with({
            filetypes = { "python" },
          }),
        },
      })

      require("lspconfig")["null-ls"].setup({
        on_attach = function(_, bufnr)
          vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>z",
            "<cmd>lua vim.lsp.buf.formatting()<CR>",
            { noremap = true, silent = true }
          )
        end,
        flags = {
          debounce_text_changes = 250,
        },
      })

      nvim_lsp.tsserver.setup({
        on_attach = function(client, bufnr)
          on_attach_common(client, bufnr)

          -- TREESITTER SLOW HIGHLIGHT HACK
          TSPrebuild.on_attach(client, bufnr)

          local ts_utils = require("nvim-lsp-ts-utils")

          ts_utils.setup({
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            import_all_priorities = {
              buffers = 4, -- loaded buffer names
              buffer_content = 3, -- loaded buffer content
              local_files = 2, -- git files or files with relative path markers
              same_file = 1, -- add to existing import statement
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- eslint
            eslint_enable_code_actions = false,
            eslint_enable_disable_comments = true,
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            eslint_opts = {},

            -- formatting
            enable_formatting = true,
            formatter = "eslint_d",
            formatter_opts = {},

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,

            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},
          })

          -- required to fix code action ranges
          ts_utils.setup_client(client)

          vim.api.nvim_buf_set_keymap(bufnr, "n", "tor", ":TSLspOrganize<CR>", { silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, "n", "tqf", ":TSLspFixCurrent<CR>", { silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, "n", "trn", ":TSLspRenameFile<CR>", { silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, "n", "tia", ":TSLspImportAll<CR>", { silent = true })
        end,
        capabilities = common_capabilities,
        flags = {
          debounce_text_changes = 150,
        },
      })

      nvim_lsp.yamlls.setup({
        on_attach = function(client, bufnr)
          on_attach_common(client, bufnr)
        end,
        capabilities = common_capabilities,
        settings = {
          yaml = {
            customTags = { "!Ref", "!ImportValue" },
          },
        },
        flags = {
          debounce_text_changes = 150,
        },
      })

      nvim_lsp.pyright.setup({
        on_attach = function(client, bufnr)
          on_attach_common(client, bufnr)
        end,
        capabilities = common_capabilities,
        flags = {
          debounce_text_changes = 150,
        },
      })

      nvim_lsp.jsonls.setup({
        cmd = { "vscode-json-languageserver", "--stdio" },
        on_attach = function(client, bufnr)
          on_attach_common(client, bufnr)
        end,
        capabilities = common_capabilities,
        flags = {
          debounce_text_changes = 150,
        },
      })

      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      nvim_lsp.sumneko_lua.setup({
        cmd = { "lua-language-server" },
        on_attach = on_attach_common,
        capabilities = common_capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = runtime_path,
            },
            diagnostics = {
              globals = { "vim", "love" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              maxPreload = 2000,
              preloadFileSize = 1000,
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        severity_sort = true,
      })
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    requires = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").load()
      vim.cmd([[
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      ]])
    end,
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = {
          autocomplete = false,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "luasnip" },
        },
      })
    end,
  })
end)

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
opt.guicursor = ""

vim.cmd([[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])

-- mappings
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<esc>", "<cmd>noh<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lo", "<cmd>copen<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lc", "<cmd>cclose<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<c-j>", "<cmd>cnext<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<c-k>", "<cmd>cprev<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", [[<cmd>set nu! rnu!<CR>]], { noremap = false, silent = true })

vim.cmd([[
augroup Terminal
  autocmd!
  au TermOpen * setlocal nonu nornu signcolumn=no | startinsert
augroup end
]])

require("colorbuddy").colorscheme("gruvbuddy")
vim.cmd([[
  hi MatchParen gui=underline
  hi StatusLine guibg=NONE
  hi StatusLine guifg=NONE
  hi StatusLineNC guibg=NONE
  hi VertSplit guifg=bg
  hi VertSplit guibg=darkgrey
]])
