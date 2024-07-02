return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
    {
      "rcarriga/nvim-notify",
      opts = {
        render = "simple",
        stages = "fade",
        timeout = 2500,
        top_down = true,
      },
      init = function()
        vim.notify = require "notify"
      end,
    },
  },
  config = function()
    require "configs.noice"
  end,
}
