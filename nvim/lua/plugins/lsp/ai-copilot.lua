return {
  { -- LSP: Github co-pilot completion plugin
    "github/copilot.vim",
    config = function()
      require "configs.ai-copilot"
    end,
  },
}
