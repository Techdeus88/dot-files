local present, fidget = pcall(require, "fidget")

if not present then
  return
end

fidget.setup {
  notification = {
    window = {
      align = "avoid_cursor",
      relative = "editor",
    },
  },
}
