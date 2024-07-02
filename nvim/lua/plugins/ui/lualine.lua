if true then
  return {}
end -- uncomment this line to activate file

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "arkav/lualine-lsp-progress", "j-hui/fidget.nvim" },
  init = function()
    vim.opt.laststatus = 0
  end,
  opts = function(_)
    local lualine = require "lualine"
    local colors = {
      --16 colors
      black = "#2e3440", -- nord0 in palette
      dark_gray = "#3b4252", -- nord1 in palette
      gray = "#434c5e", -- nord2 in palette
      light_gray = "#4c566a", -- nord3 in palette
      light_gray_bright = "#616e88", -- out of palette
      darkest_white = "#d8dee9", -- nord4 in palette
      darker_white = "#e5e9f0", -- nord5 in palette
      white = "#eceff4", -- nord6 in palette
      teal = "#8fbcbb", -- nord7 in palette
      off_blue = "#88c0d0", -- nord8 in palette
      glacier = "#81a1c1", -- nord9 in palette
      blue = "#5e81ac", -- nord10 in palette
      red = "#bf616a", -- nord11 in palette
      orange = "#d08770", -- nord12 in palette
      yellow = "#ebcb8b", -- nord13 in palette
      green = "#a3be8c", -- nord14 in palette
      purple = "#b48ead", -- nord15 in palette
      none = "none",
    }
    -- dump object contents
    local function dump(o)
      if type(o) == "table" then
        local s = ""
        for k, v in pairs(o) do
          if type(k) ~= "number" then
            k = '"' .. k .. '"'
          end
          s = s .. dump(v) .. ","
        end
        return s
      else
        return tostring(o)
      end
    end
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
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
    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
      end,
      hide_in_width_first = function()
        return vim.fn.winwidth(0) > 80
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 70
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand "%:p:h"
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }
    local config = {
      options = {
        icons_enabled = true,
        theme = "nord",
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename" },
        lualine_c = {},

        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},

        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
    }
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end
    -- inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end
    ins_left {
      "branch",
    }
    ins_left {
      "diagnostics",
    }

    -- ins_left {
    --   function()
    --     local filetype = vim.bo.filetype
    --     local formatters = require("conform").formatters_by_ft[vim.bo.filetype]

    --     if #formatters == 0 then
    --       return ""
    --     end
    --     return "󱉶 formatting with " .. table.concat(formatters, ", ")
    --   end,
    --   color = { bg = colors.green, fg = colors.darkest_white, gui = "bold" },

    --   cond = conditions.hide_in_width_first,
    --   separator = { left = "" },
    --   icon = "🌙 ",
    --   padding = { left = 1, right = 1 },
    -- }
    -- ins_left {
    --   function()
    --     local linters = require("lint").get_running()
    --     if #linters == 0 then
    --       return ""
    --     end
    --     return "󱉶 linting with " .. table.concat(linters, ", ")
    --   end,
    --   color = { bg = colors.red, fg = colors.darkest_white, gui = "bold" },
    --   cond = conditions.hide_in_width_first,
    --   icon = "🛠",
    --   separator = { right = "▓▒░", left = "░▒▓" },
    --   padding = { left = 1, right = 1 },
    -- }

    ins_right {
      function()
        local clients = vim.lsp.get_clients()
        local clients_list = {}

        local msg = "no active lsp"

        if next(clients) == nil then
          return msg
        end

        for _, client in pairs(clients) do
          if not clients_list[client.name] then
            table.insert(clients_list, client.name)
          end
        end
        local lsp_lbl = dump(clients_list):gsub("(.*),", "%1")
        return lsp_lbl:gsub(",", ", ")
      end,
      icon = " ",
      color = { bg = colors.green, fg = colors.black, gui = "bold" },
      padding = { left = 1, right = 1 },
      cond = conditions.hide_in_width_first,
      separator = { right = "▓▒░", left = "░▒▓" },
    }

    lualine.setup(config)
  end,
}
