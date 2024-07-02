local present_tag, autotag = pcall(require, "nvim-ts-autotag")

if not present_tag then
  return
end

autotag.setup {
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ["html"] = {
      enable_close = false,
    },
  },
}

