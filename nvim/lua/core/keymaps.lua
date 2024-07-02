-- ╔═══════════════════════╗
-- ║    Local Variables    ║
-- ╚═══════════════════════╝

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local keys = {
  ["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
  ["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
  ["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
}
-- ╔═══════════════════════╗
-- ║    Session Keymaps    ║
-- ╚═══════════════════════╝
-- add sessions
local split_sensibly = function()
  if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
    vim.cmd "vs"
  else
    vim.cmd "split"
  end
end

vim.cmd "let g:netrw_liststyle = 3"

-- Vim keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- ╔═══════════════════════╗
-- ║    General Keymaps    ║
-- ╚═══════════════════════╝

keymap("n", "<leader>wq", "<cmd>wqa<cr>", { noremap = true, silent = true, desc = "Quit" })
keymap("", "ö", ":")

keymap("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
keymap("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

keymap("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

-- ╔═══════════════════════╗
-- ║    Editing Keymaps    ║
-- ╚═══════════════════════╝
-- Insert a Password at point
keymap("n", "<leader>ip", function()
  local command = "pwgen -N 1 -B 32"
  for _, line in ipairs(vim.fn.systemlist(command)) do
    vim.api.nvim_put({ line }, "", true, true)
  end
end, { noremap = true, silent = true, desc = "Insert Password" })

-- ╔══════════════════════╗
-- ║    Buffer Keymaps    ║
-- ╚══════════════════════╝
keymap("n", "<leader>bx", "<cmd>bd<cr>", { noremap = true, silent = true, desc = "Close Buffer" })
keymap("n", "<leader>ba", "<cmd>%bd|e#<cr>", { noremap = true, silent = true, desc = "Close other Buffers" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { silent = true, desc = "Next Buffer" })
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { silent = true, desc = "Previous Buffer" })
keymap("n", "<TAB>", "<C-^>", { noremap = true, silent = true, desc = "Alternate buffers" })
-- Format Buffer
-- With and without LSP
if vim.tbl_isempty(vim.lsp.get_clients()) then
  keymap("n", "<leader>bf", function()
    vim.lsp.buf.format()
  end, { noremap = true, silent = true, desc = "Format Buffer" })
else
  keymap("n", "<leader>bf", "gg=G<C-o>", { noremap = true, silent = true, desc = "Format Buffer" })
end

-- ╔══════════════════╗
-- ║    UI Keymaps    ║
-- ╚══════════════════╝
-- Window Navigation
-- Alternate Window Navigation
keymap("n", "<S-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<S-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<S-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<S-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- ╔═══════════════════╗
-- ║    Git Keymaps    ║
-- ╚═══════════════════╝
keymap("n", "<leader>gl", function()
  split_sensibly()
  vim.cmd "terminal lazygit"
end, { noremap = true, silent = true, desc = "Lazygit" })
keymap("n", "<leader>pu", "<cmd>:Git pull<cr>", { noremap = true, silent = true, desc = "Git Push" })
keymap("n", "<leader>gp", "<cmd>:Git push<cr>", { noremap = true, silent = true, desc = "Git Pull" })
keymap("n", "<leader>ga", "<cmd>:Git add .<cr>", { noremap = true, silent = true, desc = "Git Add All" })
keymap(
  "n",
  "<leader>gc",
  '<cmd>:Git commit -m "Autocommit from MVIM"<cr>',
  { noremap = true, silent = true, desc = "Git Autocommit" }
)
-- keymap("", "<leader>gh", function() require('mini.git').show_range_history() end,
--     { noremap = true, silent = true, desc = 'Git Range History' })
-- keymap("n", "<leader>gx", function() require('mini.git').show_at_cursor() end,
-- { noremap = true, silent = true, desc = 'Git Context Cursor' })

-- ╔═══════════════════╗
-- ║    LSP Keymaps    ║
-- ╚═══════════════════╝
keymap("n", "<leader>ld", function()
  vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "Go To Definition" })
keymap(
  "n",
  "<leader>ls",
  "<cmd>Pick lsp scope='document_symbol'<cr>",
  { noremap = true, silent = true, desc = "Show all Symbols" }
)
keymap("n", "<leader>lr", function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "Rename This" })
keymap("n", "<leader>la", function()
  vim.lsp.buf.code_action()
end, { noremap = true, silent = true, desc = "Code Actions" })

keymap("n", "<leader>wq", "<cmd>wincmd q<cr>", { noremap = true, silent = true, desc = "Close Window" })
keymap("n", "<leader>n", "<cmd>noh<cr>", { noremap = true, silent = true, desc = "Clear Search Highlight" })
-- Split "Sensibly"
-- Should automatically split or vsplit based on Ratios
keymap("n", "<leader>bs", split_sensibly, { noremap = true, silent = true, desc = "Alternate buffers" })
-- Change Colorscheme
keymap("n", "<leader>ud", "<cmd>set background=dark<cr>", { noremap = true, silent = true, desc = "Dark Background" })
keymap("n", "<leader>ub", "<cmd>set background=light<cr>", { noremap = true, silent = true, desc = "Light Background" })

-- Exit Terminal
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Editor: Exit mode alternate
keymap("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- New tab
keymap("n", "te", ":tabedit<Return>")
-- Navigate tabs
keymap("n", "<tab>", ":tabnext<Return>", opts)
keymap("n", "<s-tab>", ":tabprev<Return>", opts)
-- Navigate Panes

-- Split window
keymap("n", "ss", ":split<Return>", { desc = "Split the window horizontally" })
keymap("n", "sv", ":vsplit<Return>", { desc = "Split the window vertically" })

-- Resize window
keymap("n", "<C-w><left>", "<C-w><")
keymap("n", "<C-w><right>", "<C-w>>")
keymap("n", "<C-w><up>", "<C-w>+")
keymap("n", "<C-w><down>", "<C-w>-")

-- Better close & exit
keymap("n", "<leader>Q", "<CMD>q<CR>", { desc = "󰗼 Close" })
keymap("n", "<leader>qq", "<<CMD>qa!<CR>", { desc = "󰗼 Exit" })

-- Editor -> Text keymaps

-- Increment/decrement
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- Delete a word backwards
keymap("n", "dw", 'vb"_d')

-- No Highlight search
keymap("n", "<leader>h", ":nohlsearch<CR>")

-- Set BG to Dark or Light
keymap("n", "<leader>cd", "<CMD>:set background=dark<CR>", { desc = "Set BG to Dark" })
keymap("n", "<leader>cl", "<CMD>:set background=light<CR>", { desc = "Set BG to Light" })

-- No Arrow Keys in normal mode
keymap("n", "<left>", "<cmd>echo \"Use 'h' to move!!\"<CR>")
keymap("n", "<right>", "<cmd>echo \"Use 'l' to move!!\"<CR>")
keymap("n", "<up>", "<cmd>echo \"Use 'k' to move!!\"<CR>")
keymap("n", "<down>", "<cmd>echo \"Use 'j' to move!!\"<CR>")

-- Diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
