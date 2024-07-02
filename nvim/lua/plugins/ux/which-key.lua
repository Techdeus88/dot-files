return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function() -- This is the function that runs, AFTER loading
    require "configs.which-key"
  end,
}

