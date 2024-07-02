-- ██╗      █████╗ ███████╗██╗   ██╗         Z
-- ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝      Z
-- ██║     ███████║  ███╔╝  ╚████╔╝    z
-- ██║     ██╔══██║ ███╔╝    ╚██╔╝   z
-- ███████╗██║  ██║███████╗   ██║
-- ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝

-- Install lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
-- install lazy
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end

vim.opt.rtp:prepend(lazypath)
-- Configure Lazy.nvim and load ALL plugins
local present, lazy = pcall(require, "lazy")

if not present then
  print "lazy just installed, please restart neovim"
  return
end

lazy.setup {
  spec = {
    require "plugins.ui.dashboard",
    require "plugins.ui.breadcrumbs",
    require "plugins.ui.theme",
    require "plugins.ui.windows",
    require "plugins.ui.noice",
    require "plugins.ui.mini",
    require "plugins.ui.treesitter",
    require "plugins.ui.augment",
    require "plugins.ui.lualine",
    require "plugins.ui.editor",
    require "plugins.ux.multi-editing",
    require "plugins.ui.transparent",

    require "plugins.ux.auto-pairs",
    require "plugins.ux.sessions",
    require "plugins.ux.comments",
    require "plugins.ux.oil",
    require "plugins.ux.oil-vcs",
    require "plugins.ux.git",
    require "plugins.ux.grapple",
    require "plugins.ux.notes",
    require "plugins.ux.starter",
    require "plugins.ux.status-line",
    require "plugins.ux.telescope",
    require "plugins.ux.toggle-term",
    require "plugins.ux.which-key",

    require "plugins.lsp.config",
    require "plugins.lsp.cmp",
    require "plugins.lsp.format-file",
    require "plugins.lsp.lint-file",
    require "plugins.lsp.trouble",
    require "plugins.lsp.augment",
    require "plugins.lsp.ai-copilot",
  },
  install = { colorscheme = { "nord" } },
  dev = {
    fallback = true,
    path = "~/.local/src",
  },
  checker = { enabled = true },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        -- netrwPlugin
      },
    },
  },
  {
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
  },
}
