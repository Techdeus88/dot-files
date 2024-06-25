local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
-- Configure 'core' and 'utils' directories
  -- Core: options, keymaps, and commands
  -- Utils: global helpers, checkhealth and other checks

require "techdeus.core"
require "techdeus.utils"
-- Configure Lazy.nvim and load ALL plugins
require "techdeus.configs.lazy"

-- Set the mode below
-- vim: ts=2 sts=2 sw=2 et