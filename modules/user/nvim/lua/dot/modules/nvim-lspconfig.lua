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
    null_ls.builtins.formatting.phpcbf.with({
      filetypes = { "php" },
      command = { "phpcbf" },
      args = { "--standard=PSR12", "-" },
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

nvim_lsp.intelephense.setup({
  on_attach = on_attach_common,
})

nvim_lsp.rnix.setup({
  on_attach = on_attach_common,
})

nvim_lsp.hls.setup({
  on_attach = on_attach_common,
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
