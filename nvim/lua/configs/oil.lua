local present, oil = pcall(require, "oil")

if not present then
  return
end

local detail = false
local git_ignored = setmetatable({}, {
  __index = function(self, key)
    local proc = vim.system({ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }, {
      cwd = key,
      text = true,
    })
    local result = proc:wait()
    local ret = {}
    if result.code == 0 then
      for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
        -- Remove trailing slash
        line = line:gsub("/$", "")
        table.insert(ret, line)
      end
    end

    rawset(self, key, ret)
    return ret
  end,
})

oil.setup {
  win_options = {
    signcolumn = "yes:2",
  },
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          require("oil").set_columns { "icon", "permissions", "size", "mtime" }
        else
          require("oil").set_columns { "icon" }
        end
      end,
    },
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["l"] = "actions.select",
    ["<C-k>"] = "actions.select_vsplit",
    ["<C-j>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["q"] = "actions.close",
    ["esc"] = "actions.close",
    ["r"] = "actions.refresh",
    ["h"] = "actions.parent",
    --    ["-"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = false,
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, _)
      if vim.startswith(name, ".") then
        return true
      end
      local dir = require("oil").get_current_dir()
      if not dir then
        return false
      end
      return vim.list_contains(git_ignored[dir], name)
    end,
  },
  float = {
    max_height = 45,
    max_width = 90,
    preview_split = "below",
  },
}

vim.keymap.set("n", "-", "<CMD>Oil<CR>")
vim.keymap.set("n", "_", "<CMD>Oil.toggle_float()<cr>")
