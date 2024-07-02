return {
  "akinsho/toggleterm.nvim",
  keys = { [[<C-\>]] },
  cmd = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll" },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 0.40 * vim.api.nvim_win_get_height(0)
      elseif term.direction == "vertical" then
        return 0.40 * vim.api.nvim_win_get_width(0)
      elseif term.direction == "float" then
        return 85
      end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = false,
    insert_mappings = true,
    start_in_insert = true,
    persist_size = true,
    direction = "vertical",
    close_on_exit = true,
    shell = vim.o.shell,
    autochdir = true,
    highlights = {
      NormalFloat = {
        link = "Normal",
      },
      FloatBorder = {
        link = "FloatBorder",
      },
    },
    float_opts = {
      border = "rounded",
      winblend = 0,
    },
  },
  init = function()
    local trim_spaces = true
    vim.keymap.set("n", "<C-S-t>", "<CMD>ToggleTerm size=85 dir=~/ direction=float name=Home<cr>")
    vim.keymap.set("v", "<leader>tt", function()
      require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
    end)

    vim.keymap.set("n", [[<leader><c-\>]], function()
      set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
      end)
      vim.api.nvim_feedkeys("g@", "n", false)
    end)
    -- Double the command to send line to terminal
    vim.keymap.set("n", [[<leader><c-\><c-\>]], function()
      set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
      end)
      vim.api.nvim_feedkeys("g@_", "n", false)
    end)
    -- Send whole file
    vim.keymap.set("n", [[<leader><leader><c-\>]], function()
      set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
      end)
      vim.api.nvim_feedkeys("ggg@G''", "n", false)
    end)
    require "configs.toggle-term"
  end,
}
