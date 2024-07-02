local present, nord = pcall(require, "nord")

if not present then
  return
end

nord.set()

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nord",
  -- group = ...,
  callback = function()
    vim.api.nvim_set_hl(0, "CopilotSuggestion", {
      fg = "#555555",
      ctermfg = 8,
      force = true,
    })
  end,
})
