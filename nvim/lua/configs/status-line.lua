local present, statusline = pcall(require, "incline")
local devicons = require "nvim-web-devicons"

if not present then
  return
end

local colors = require "nord.named_colors"
local mode_color = {
  n = colors.red,
  i = colors.green,
  v = colors.blue,
  V = colors.blue,
  x = colors.blue,
  [""] = colors.blue,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  [""] = colors.orange,
  ic = colors.yellow,
  r = colors.yellow,
  rv = colors.yellow,
  cv = colors.yellow,
  ce = colors.yellow,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.red,
}

statusline.setup {
  window = {
    placement = {
      vertical = "bottom",
      horizontal = "center",
    },
    padding = 0,
    margin = { vertical = 0, horizontal = 0 },
  },
  hide = {
    cursorline = false,
  },
  debounce_threshold = { falling = 500, rising = 250 },
  render = function(props)
    local deus_icons = require("utils.theme").icons
    local deus_colors = require("utils.theme").colors
    local mode = {}

    local function get_mode()
      local modes = {
        n = "Normal",
        c = "CMD-line",
        s = "Select",
        v = "Visual",
        V = "Visual",
        x = "Visual",
        i = "Insert",
        r = "Replace",
        o = "Operator pending",
        t = "Terminal",
        l = "Langmap",
        [""] = "Normal, Visual and Operator pending",
      }

      local current_mode = vim.api.nvim_get_mode().mode
      local current_mode_bg_color = mode_color[current_mode]
      local current_mode_fg_color = deus_colors.darkest_white

      table.insert(mode, { " " })
      table.insert(mode, { string.upper(current_mode), guifg = current_mode_fg_color, guibg = current_mode_bg_color })
      table.insert(mode, { " " })

      return { mode, guibg = current_mode_bg_color }
    end

    local function get_filename()
      local label = {}
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      if filename == "" then
        filename = "[Directory]"
      end
      local ft_icon, ft_color = devicons.get_icon_color(filename)
      local modified = vim.bo[props.buf].modified

      table.insert(label, { " " })
      table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
      table.insert(label, { " " })
      table.insert(label, {
        filename,
        gui = vim.bo[props.buf].modified and "bold,italic" or "bold",
        guifg = modified and deus_colors.red or deus_colors.darkest_white,
      })
      table.insert(label, { " " })
      table.insert(label, { vim.bo[props.buf].modified and " " or "", guifg = "#d19a66" })
      table.insert(label, { " " })

      if not props.focused then
        label["group"] = "BufferInactive"
      end

      return label
    end

    local function get_diagnostics()
      local icons = { error = " ", warn = " ", info = " ", hint = " " }

      local label = {}

      for severity, icon in pairs(icons) do
        local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
        if n > 0 then
          table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
        end
      end
      return {
        { label },
      }
    end

    local function get_git_diff()
      local icons =
        { removed = deus_icons.git.Removed, changed = deus_icons.git.Modified, added = deus_icons.git.Added }
      local signs = vim.b[props.buf].gitsigns_status_dict
      local labels = {}
      if signs == nil then
        return labels
      end
      for name, icon in pairs(icons) do
        if tonumber(signs[name]) and signs[name] > 0 then
          table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
        end
      end
      return { { labels } }
    end

    local function get_grapple_status()
      local grapple_status
      grapple_status = require("grapple").name_or_index { buffer = props.buf } or ""
      if grapple_status ~= "" then
        grapple_status = { { " 󰛢 ", group = "Function" }, { grapple_status, group = "Constant" }, { "  " } }
      else
        grapple_status = { { " 󰛢 ", group = "" }, { 0, group = "Constant" }, { "  " }, guifd = deus_colors.gray }
      end
      return { { grapple_status } }
    end

    local function get_session_name()
      local s_name = require("auto-session.lib").current_session_name()
      print(s_name)
      return { s_name == nil and "No session" or s_name }
    end

    local function get_search_term()
      if vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0 then
        return
      end

      local count = vim.fn.searchcount { recompute = 1, maxcount = -1 }
      local contents = vim.fn.getreg "/"

      return {
        { (" (%d/%d)"):format(count.current, count.total), group = "IncSearch" },
        { (" %s  "):format(contents), group = "IncSearch" },
        { "", group = "StatusKey" },
      }
    end

    return {
      { get_mode() },
      { get_grapple_status() },
      { get_session_name() },
      { get_diagnostics() },
      { get_filename() },
      { get_git_diff() },
      { get_search_term() },
    }
  end,
}
