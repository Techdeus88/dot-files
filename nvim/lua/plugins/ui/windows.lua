return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 0
      vim.opt.splitkeep = "screen"
    end,
    config = function()
      require "edgy".setup({
        wo = {
          winbar = true,
          signcolumn = "no",
        },
      })
    end,
}