return {
  -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require("techdeus.configs.mini")
  end
}