return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("techdeus.configs.oil")
  end
}