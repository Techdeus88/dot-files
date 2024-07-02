return {
  -- Treesitter: File Highlighting, indenting and other abstractions.
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    config = function()
      require "nvim-ts-autotag"
    end,
  },
  config = function(_, opts)
    require "configs.treesitter"
    -- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    -- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    -- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
