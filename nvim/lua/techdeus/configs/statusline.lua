local present, statusline = pcall(require, "incline")
local devicons = require("nvim-web-devicons")

if not present then
  return
end

statusline.setup {
  hide = {
    cursorline = false,
    focused_win = false,
    only_win = false,
  },
  window = {
    placement = {
      horizontal = "right",
      vertical = "bottom"
    },
  },
  render = function(props)
    local deus_icons = require("techdeus.utils.theme").icons
    local deus_colors = require("techdeus.utils.theme").colors

    local function get_filename()
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      if filename == "" then
        filename = "[No name]"
      end
      local ft_icon, ft_color = devicons.get_icon_color(filename)
      local modified = vim.bo[props.buf].modified
      return {
        " ",
        { filename, gui = modified and "bold,italic" or "bold", guifg = modified and deus_colors.red or deus_colors.darkest_white },
        " ",
        ft_icon and { ft_icon, " ", guibg = "none", guifg = ft_color } or "",
      }
    end

    local function get_diagnostics()
        local icons = {
          error = deus_icons.diagnostics.Error,
          warn = deus_icons.diagnostics.Warn,
          info = deus_icons.diagnostics.Info,
          hint = deus_icons.diagnostics.Hint,
        }
        local labels = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(labels, { " " .. icon .. n, group = "DiagnosticSign" .. severity })
          end
        end
        if #labels > 0 then
          table.insert(labels, { " ┊" })
        end
        return labels
      end
  
    local function get_mini_diff()
      local icons = {
            add = deus_icons.git.added,
            change = deus_icons.git.modified,
            delete = deus_icons.git.removed,
          }
          local signs = vim.b[props.buf].minidiff_summary

          local labels = {}
          if signs == nil then
            return labels
          end
          
      if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { " ", icon .. signs[name], group = "MiniDiffSign" .. name })
            end
          if #labels > 0 then
            table.insert(labels, { " 󰊢 " .. signs.n_ranges .. " ┊" })
          end
          return labels
      end

    local function get_grapple_status()
        local grapple_status
        grapple_status = require("grapple").name_or_index({ buffer = props.buf }) or ""
        if grapple_status ~= "" then
          grapple_status = { { " 󰛢 ", group = "Function" }, { grapple_status, group = "Constant" } }
        end
        return grapple_status
    end

    local function get_search_term()
      if not props.focused then return "" end

      local count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
      local contents = vim.fn.getreg("/")
      if string.len(contents) == 0 then return "" end

      return {
        { " ? ", group = "deusStatusKey", },
        { (" %s "):format(contents), group = "IncSearch", },
        { (" %d/%d "):format(count.current, count.total), group = "deusStatusValue", },
      }
    end

  return {
      { get_diagnostics() },
      { get_mini_diff() },
      -- { get_search_term() },
      -- { get_grapple_status() },
      { get_filename() },
      group = props.focused and "ColorColumn" or "SignColumn",
    }
  end
}
