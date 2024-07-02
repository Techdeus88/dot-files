return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require "configs.comments"
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
    },
  },
}
