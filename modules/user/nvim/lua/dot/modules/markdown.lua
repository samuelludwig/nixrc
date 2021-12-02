return {
  setup = function() end,
  packages = {
    { "ellisonleao/glow.nvim",
      config = function()
        vim.g.glow_border = "rounded"
      end,
    },
  },
  config = function() end,
  exports = {},
}
