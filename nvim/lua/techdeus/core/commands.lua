-- Vim cmds and autocmds
local api = vim.api

-- Highlight when yanking text
api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
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
api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		-- Default: 3
		vim.opt.conceallevel = 0
	end,
})

-- Show cursor line only in active window
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		if vim.w.auto_cursorline then
			vim.wo.cursorline = true
			vim.w.auto_cursorline = nil
		end
	end,
})
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		if vim.wo.cursorline then
			vim.w.auto_cursorline = true
			vim.wo.cursorline = false
		end
	end,
})

-- Create backups for all open buffers
api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("better_backup", { clear = true }),
	callback = function(event)
		local file = vim.uv.fs_realpath(event.match) or event.match
		local backup = vim.fn.fnamemodify(file, ":p:~:h")
		backup = backup:gsub("[/\\]", "%%")
		vim.go.backupext = backup
	end,
})

-- Add a new filetype ".dts"
vim.filetype.add({
	extension = {
		overlay = "dts",
		keymap = "dts",
	},
})

-- Split the window vertically at start
-- api.nvim_create_autocmd("VimEnter", {
--	command = "vsplit", -- vim.cmd = "vsplit<Return>"
-- })
