local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.cmd "let g:netrw_liststyle = 3"

-- Vim keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Exit Terminal
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Editor: Exit mode alternate
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- New tab
keymap.set("n", "te", ":tabedit<Return>")

-- Navigate tabs
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Navigate Panes

-- Navigate vim panes better with move window
keymap.set('n', '<c-k>', ':wincmd k<CR>', { desc = "Move focus to the left window"})
keymap.set('n', '<c-j>', ':wincmd j<CR>', { desc = "Move focus to the right window"})
keymap.set('n', '<c-h>', ':wincmd h<CR>', { desc = "Move focus to the lower window"})
keymap.set('n', '<c-l>', ':wincmd l<CR>', { desc = "Move focus to the upper window"})

-- Split window
keymap.set("n", "ss", ":split<Return>", opts, { desc = "Split the window horizontally" })
keymap.set("n", "sv", ":vsplit<Return>", opts, { desc = "Split the window vertically" })

-- keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")
-- Better close & exit
keymap.set("n", "<leader>Q", "<CMD>q<CR>", { desc = "󰗼 Close" })
keymap.set("n", "<leader>qq", "<<CMD>qa!<CR>", { desc = "󰗼 Exit" })

-- Editor -> Text keymaps 

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- No Highlight search
keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Set BG to Dark or Light
keymap.set('n', '<leader>cd', '<CMD>:set background=dark<CR>', { desc = "Set BG to Dark"})
keymap.set('n', '<leader>cl', '<CMD>:set background=light<CR>', { desc = "Set BG to Light"})

-- No Arrow Keys in normal mode
keymap.set("n", "<left>", '<cmd>echo "Use \'h\' to move!!"<CR>')
keymap.set("n", "<right>", '<cmd>echo "Use \'l\' to move!!"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Use \'k\' to move!!"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Use \'j\' to move!!"<CR>')

-- Diagnostics
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
