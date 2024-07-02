return {
  -- Component: Twilight to dim the unused or unseen parts of the code
  { "folke/twilight.nvim" },
  -- Component: Full screen focused coding & powered with Zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        -- kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
