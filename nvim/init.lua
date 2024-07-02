--                                     ██
--                                    ░░
--  ███████   █████   ██████  ██    ██ ██ ██████████
-- ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
--  ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
--  ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
--  ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██
-- ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
--
--  ▓▓▓▓▓▓▓▓▓▓
-- ░▓ author ▓ techdeus <techdeusms@gmail.com>
-- ░▓ code   ▓ https://github.com/Techdeus88/dot-files
-- ░▓ mirror ▓ https://github.com/Techdeus88/dot-files
-- ░▓▓▓▓▓▓▓▓▓▓
-- ░░░░░░░░░░

-- Configure 'core' and 'utils' directories
-- Core: options, keymaps, and commands
-- Utils: global helpers, checkhealth and other checks

require "core"

if vim.g.noplugins == nil then
  require "plugins"
else
  local colors = vim.fn.stdpath "data" .. "/lazy/nord.nvim/colors/nord.vim"
  if vim.fn.filereadable(colors) then
    vim.cmd("source " .. colors)
  end
end
