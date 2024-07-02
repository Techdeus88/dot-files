local present, copilot = pcall(require, "copilot")

if not present then
  return
end

vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#03a598" })

copilot.setup {
  panel = {
    enabled = true,
    auto_refresh = false,
    layout = {
      position = "bottom",
      ratio = 0.4,
    },
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<leader>ck",
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<C-v>",
      accept_word = false,
      accept_line = "<C-q>",
      next = false,
      prev = false,
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    markdown = true,
    javascript = true,
    typescript = true,
    python = true,
    rust = true,
    go = true,
    gitcommit = false,
    yaml = false,
    help = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    VimspectorPrompt = false,
    ["*"] = false,
  },
  copilot_node_command = "node",
  server_opts_overrides = {},
}
