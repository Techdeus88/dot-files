local present, lazy = pcall(require, "lazy")

if not present then
  return
end

lazy.setup({
  spec = {
    { import = "techdeus.plugins" },
  },
  defaults = {
    lazy = false,
  },
  install = {
    colorscheme = {
      "nord",
    },
  },
  checker = {
    enabled = true,
  },
  performance = {
    rtp = {
      disabled_plugins = { -- disable some rtp plugins
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "matchit",
        "matchparen",
        -- netrwPlugin
      },
    },
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and not {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})