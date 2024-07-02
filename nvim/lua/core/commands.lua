-- Vim cmds and autocmds
local api = vim.api
local ac = api.nvim_create_autocmd
local ag = api.nvim_create_augroup

-- Disable diagnostics in a .env file
ac("BufRead", {
  pattern = ".env",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

local auto_close_filetype = {
  "lazy",
  "mason",
  "lspinfo",
  "toggleterm",
  "null-ls-info",
  "TelescopePrompt",
  "notify",
}
-- Auto close window when leaving
ac("BufLeave", {
  group = ag("lazyvim_auto_close_win", { clear = true }),
  callback = function(event)
    local ft = vim.api.nvim_buf_get_option(event.buf, "filetype")

    if vim.fn.index(auto_close_filetype, ft) ~= -1 then
      local winids = vim.fn.win_findbuf(event.buf)
      for _, win in pairs(winids) do
        vim.api.nvim_win_close(win, true)
      end
    end
  end,
})

-- Disable leader and localleader for some filetypes
ac("FileType", {
  group = ag("lazyvim_unbind_leader_key", { clear = true }),
  pattern = {
    "lazy",
    "mason",
    "lspinfo",
    "toggleterm",
    "null-ls-info",
    "TelescopePrompt",
    "notify",
    "floaterm",
  },
  callback = function(event)
    vim.keymap.set("n", "<leader>", "<nop>", { buffer = event.buf, desc = "" })
    vim.keymap.set("n", "<localleader>", "<nop>", { buffer = event.buf, desc = "" })
  end,
})

-- Delete number column on terminals
ac("TermOpen", {
  callback = function()
    vim.cmd "setlocal listchars= nonumber norelativenumber"
    vim.cmd "setlocal nospell"
  end,
})

-- Disable eslint on node_modules
ac({ "BufNewFile", "BufRead" }, {
  group = ag("DisableEslintOnNodeModules", { clear = true }),
  pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
  callback = function()
    vim.diagnostic.disable(false)
  end,
})



-- Highlight when yanking text
ac("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Turn off paste mode when leaving insert
api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
ac("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    -- Default: 3
    vim.opt.conceallevel = 0
  end,
})

-- Show cursor line only in active window
ac({ "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
ac({ "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- Create backups for all open buffers
ac("BufWritePre", {
  group = api.nvim_create_augroup("better_backup", { clear = true }),
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- Add a new filetype ".dts"
vim.filetype.add {
  extension = {
    overlay = "dts",
    keymap = "dts",
  },
}

-- vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

-- Disable next line comments
-- ac("BufEnter", {
--   callback = function()
--     vim.cmd "set formatoptions-=cro"
--     vim.cmd "setlocal formatoptions-=cro"
--   end,
-- })

-- Toggle between relative/absolute line numbers
-- local numbertoggle = ag("numbertoggle", { clear = true })
-- ac({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
--   pattern = "*",
--   group = numbertoggle,
--   callback = function()
--     if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
--       vim.opt.relativenumber = true
--     end
--   end,
-- })

-- ac({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
--   pattern = "*",
--   group = numbertoggle,
--   callback = function()
--     if vim.o.nu then
--       vim.opt.relativenumber = false
--       vim.cmd.redraw()
--     end
--   end,
-- })

-- Create a dir when saving a file if it doesnt exist
-- ac("BufWritePre", {
--   group = ag("auto_create_dir", { clear = true }),
--   callback = function(args)
--     if args.match:match "^%w%w+://" then
--       return
--     end
--     local file = vim.uv.fs_realpath(args.match) or args.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
--   end,
-- })

-- Automatically close terminal Buffers when their Process is done
-- api.nvim_create_autocmd("TermClose", {
--     callback = function()
--         vim.cmd("bdelete")
--     end
-- })

-- -- Disable Linenumbers in Terminals
-- ac("TermEnter", {
--   callback = function()
--     vim.o.number = false
--     vim.o.relativenumber = false
--   end,
-- })



-- api.nvim_create_autocmd("VimEnter", {
  -- Split the window vertically at start
--	command = "vsplit", -- vim.cmd = "vsplit<Return>"
-- })

