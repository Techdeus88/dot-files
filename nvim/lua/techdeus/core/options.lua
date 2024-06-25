-- Create locals
local opt = vim.opt
local g = vim.g
local o = vim.o
local wo = vim.wo
local cmd = function(command) vim.cmd(command) end

-- VIM OPTIONS
cmd("set expandtab")
cmd("set tabstop=2")
cmd("set softtabstop=2")
cmd("set shiftwidth=2")
cmd("set background=dark")

-- Terminal color spec
opt.termguicolors = true

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

-- Backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

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
opt.sessionoptions = {
  "buffers",
  "tabpages",
  "globals",
}