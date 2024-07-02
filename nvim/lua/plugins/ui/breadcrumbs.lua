if vim.fn.has "nvim-0.10" == 1 then
  return {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    opts = {
      sources = {
        terminal = {
          name = "",
        },
      },
    },
  }
end
