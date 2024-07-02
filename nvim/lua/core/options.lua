-- Create locals
local opt = vim.opt
local wo = vim.wo
local o = vim.o

-- Enable EditorConfig integration
vim.g.editorconfig = true

-- VIM OPTIONS
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.background = dark
opt.hlsearch = true
-- opt.nohlsearch = true

-- Terminal color spec
opt.termguicolors = true
-- Remove default statusline
opt.laststatus = 0
-- vim.api.nvim_set_hl(0, "Statusline", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "StatuslineNC", { link = "Normal" })
--
-- local str = string.repeat('-', vim.api.nvim_win_get_width(0))
-- opt.statusline = str
-- File formats & encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.swapfile = false

-- File indent rules
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true
opt.wrap = true
opt.cursorline = true

-- File number specfics
wo.number = true
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = true

-- Search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- Clipboard
opt.clipboard = "unnamedplus"
opt.clipboard:append "unnamedplus" -- use system clipboard as default register

-- Update time
opt.updatetime = 100
opt.showmode = true

-- List options
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Mouse move events
opt.mouse = "a"
opt.mousemoveevent = true

-- Session option
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"
-- Enable spell checking
o.spell = true
o.spelllang = "en"

-- Backspacing and indentation when wrapping
o.backspace = "start,eol,indent"
o.breakindent = true

-- Smoothscroll
if vim.fn.has "nvim-0.10" == 1 then
  o.smoothscroll = true
end
