return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      {
        "williamboman/mason.nvim",
        config = function()
          require "configs.mason"
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { -- Figet handles LSP progress notifications and messages
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        config = function()
          require "configs.fidget"
        end,
      },
      { -- handles all dap related config
        "mfussenegger/nvim-dap",
        dependencies = {
          -- Creates a beautiful debugger UI
          "rcarriga/nvim-dap-ui",
          -- Required dependency for nvim-dap-ui
          "nvim-neotest/nvim-nio",
          -- Installs the debug adapters for you
          "williamboman/mason.nvim",
          "jay-babu/mason-nvim-dap.nvim",
          -- Add your own debuggers here
          "leoluz/nvim-dap-go",
        },
        config = function()
          require "configs.dap"
        end,
      },
    },
    config = function()
      require "configs.lsp"
    end,
  },
}
