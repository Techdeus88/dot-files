return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local pairs = require "configs.auto-pairs"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    },
    config = function()
      local tags = require "configs.auto-tags"
    end,
  },
}

