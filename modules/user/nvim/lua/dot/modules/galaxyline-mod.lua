return {
  packages = {
    {
      'NTBBloodbath/galaxyline.nvim',
      config = function()
        require('galaxyline.themes.eviline')
        --require('galaxyline.themes.spaceline')
        --require('galaxyline.themes.neonline')
      end,
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    },
  },
}
