local present, toggleterm = pcall(require, "toggleterm.terminal")
local Terminal = toggleterm.Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true, size = 85, direction = "float" }

if not present then
  return
end

function _Lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _Lazygit_toggle()<CR>", { noremap = true, silent = true })
