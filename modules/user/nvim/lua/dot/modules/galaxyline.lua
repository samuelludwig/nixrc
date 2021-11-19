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
