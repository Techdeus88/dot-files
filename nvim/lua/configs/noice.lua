local prevent, noice = pcall(require, "noice")

if not prevent then
  return
end

noice.setup {
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    format = {
      cmdline = { pattern = "^:", icon = "󰘳 ", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = "󰩊 ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = "󰩊 ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "󰻿 ", lang = "bash" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "󰞋 " },
    },
  },
  popupmenu = {
    enabled = true,
    backend = "nui",
  },
  routes = {
    {
      filter = {
        event = "lsp",
        any = {
          { find = "formatting" },
          { find = "Diagnosing" },
          { find = "Diagnostics" },
          { find = "diagnostics" },
          { find = "code_action" },
          { find = "Processing full semantic tokens" },
          { find = "symbols" },
          { find = "completion" },
        },
      },
      opts = { skip = true },
    },
    {
      filter = {
        any = {
          { find = "No information available" },
          { find = "No references found" },
          { find = "No lines in buffer" },
        },
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "notify",
        any = {
          -- Neo-tree
          { find = "Toggling hidden files: true" },
          { find = "Toggling hidden files: false" },
          { find = "Operation canceled" },
          { find = "^No code actions available$" },
          -- Telescope
          { find = "Nothing currently selected" },
          { find = "^No information available$" },
          { find = "Highlight group" },
          { find = "no manual entry for" },
          { find = "not have parser for" },
          -- ts
          { find = "_ts_parse_query" },
        },
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        any = {
          -- Edit
          { find = "%d+ less lines" },
          { find = "%d+ fewer lines" },
          { find = "%d+ more lines" },
          { find = "%d+ change;" },
          { find = "%d+ line less;" },
          { find = "%d+ more lines?;" },
          { find = "%d+ fewer lines;?" },
          { find = '".+" %d+L, %d+B' },
          { find = "%d+ lines yanked" },
          { find = "^Hunk %d+ of %d+$" },
          { find = "%d+L, %d+B$" },
          { find = "^[/?].*" }, -- Searching up/down
          { find = "E486: Pattern not found:" }, -- Searcingh not found
          { find = "%d+ changes?;" }, -- Undoing/redoing
          { find = "%d+ fewer lines" }, -- Deleting multiple lines
          { find = "%d+ more lines" }, -- Undoing deletion of multiple lines
          { find = "%d+ lines " }, -- Performing some other verb on multiple lines
          { find = "Already at newest change" }, -- Redoing
          { find = '"[^"]+" %d+L, %d+B' }, -- Saving
          -- Save
          { find = " bytes written" },
          -- Redo/Undo
          { find = " changes; before #" },
          { find = " changes; after #" },
          { find = "1 change; before #" },
          { find = "1 change; after #" },
          -- Yank
          { find = " lines yanked" },
          -- Move lines
          { find = " lines moved" },
          { find = " lines indented" },
          -- Bulk edit
          { find = " fewer lines" },
          { find = " more lines" },
          { find = "1 more line" },
          { find = "1 line less" },
          -- General messages
          { find = "Already at newest change" }, -- Redoing
          { find = "Already at oldest change" },
          { find = "E21: Cannot make changes, 'modifiable' is off" },
        },
      },
      opts = { skip = true },
    },
  },

  lsp = {
    progress = {
      enabled = true,
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true,
        luasnip = true,
        throttle = 50,
      },
      opts = {
        focusable = false,
        size = {
          max_height = 15,
          max_width = 60,
        },
        win_options = {
          wrap = false,
        },
      },
    },
    hover = {
      silent = true,
    },
    documentation = {
      opts = {
        border = {
          padding = { 0, 0 },
        },
      },
    },
    override = {
      -- override the default lsp markdown formatter with Noice
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      -- override the lsp markdown formatter with Noice
      ["vim.lsp.util.stylize_markdown"] = true,
      -- override cmp documentation with Noice (needs the other options to work)
      ["cmp.entry.get_documentation"] = true,
    },
  },
  views = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      search_down = { kind = "search", pattern = "^/", icon = "󰩊 ", lang = "regex" },
    },
    cmdline_popup = {
      zindex = 200,
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        min_width = 60,
        width = "auto",
        height = "auto",
      },
    },
    cmdline_input = {
      view = "cmdline_popup",
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
    },
    confirm = {
      backend = "popup",
      relative = "editor",
      focusable = false,
      align = "center",
      enter = false,
      zindex = 210,
      format = { "{confirm}" },
      position = {
        row = "50%",
        col = "50%",
      },
      size = "auto",
      border = {
        style = "rounded",
        padding = { 0, 1 },
        text = {
          top = " Confirm ",
        },
      },
    },
    popupmenu = {
      relative = "editor",
      zindex = 100,
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
    mini = {
      zindex = 100,
      win_options = { winblend = 0 },
    },
  },
  presets = {
    bottom_search = false,
    command_palette = true, -- position the cmdline and popupmenu together
    inc_rename = true, -- enables an input dialog for inc-rename.nvim
    long_message_to_split = true, -- long messages will be sent to a split
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  commands = {
    all = {
      view = "split",
      opts = { enter = true, format = "details" },
      filter = {},
    },
  },
  opts = function(_, opts)
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })
    local focused = true
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        focused = true
      end,
    })
    vim.api.nvim_create_autocmd("FocusLost", {
      callback = function()
        focused = false
      end,
    })
    table.insert(opts.routes, 1, {
      filter = {
        cond = function()
          return not focused
        end,
      },
      view = "notify_send",
      opts = { stop = false },
    })
  end,
}
