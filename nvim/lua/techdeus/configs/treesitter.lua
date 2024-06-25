local present_install, treesitter_install = pcall(require, "nvim-treesitter.install")
local present_configs, treesitter_configs = pcall(require, "nvim-treesitter.configs")

if not present_install then
  return
end

if not present_configs then
  return
end

treesitter_install.prefer_git = true
treesitter_configs.setup({
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "query",
    "vimdoc",
    "c",
    "regex",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = {
    enable = true,
    disable = { 'ruby' },
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = "gnn", -- set to `false` to disable one of the mappings
      -- node_incremental = "grn",
      -- scope_incremental = "grc",
      -- node_decremental = "grm",
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  auto_install = true,
})
