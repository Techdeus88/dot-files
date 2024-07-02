local present, auto_session = pcall(require, "auto-session")

if not present then
  return
end

auto_session.setup {
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/src", "package.json" },
  auto_session_enable_last_session = false,
  session_lens = {
    -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
    buftypes_to_ignore = {}, -- list of buffer types that should not be deleted from current session when a new one is loaded
  },
}

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
  noremap = true,
})
