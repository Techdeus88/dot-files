local present, which_key = pcall(require, "which-key")

which_key.setup {
  -- Document existing key chains
  which_key.register {
    ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
    ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
    ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
    ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
    ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
    ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
    ["<leader>g"] = { name = "[G]it Hunk", _ = "which_key_ignore" },
  },
  -- Document visual mode key chains
  which_key.register({
    ["<leader>gh"] = { "Git [H]unk" },
  }, { mode = "v" }),
}
