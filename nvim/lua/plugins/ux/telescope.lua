return {
  -- Component: Fuzzy file finder over lists
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",
      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",
      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "jvgrootveld/telescope-zoxide" },
    { "nvim-telescope/telescope-media-files.nvim" },
    {
      "nvim-telescope/telescope-project.nvim",
      lazy = false,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    -- local transform_mod = require("telescope.actions.mt").transform_mod
    -- local trouble = require("trouble")
    -- local trouble_telescope_sources = require("trouble.sources.telescope")
    -- or create your custom action
    -- local custom_actions = transform_mod({
    -- 	open_trouble_qflist = function()
    -- 		trouble.toggle("quickfix")
    -- 	end,
    -- })
    local custom_telescope_theme = {
      pickers = {
        find_files = {
          find_command = { "rg", "--type=file", "--hidden", "--smart-case" },
        },
        live_grep = {
          only_sort_text = true,
        },
      },
      layout_config = {
        prompt_position = "bottom",
        horizontal = {
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      scroll_strategy = "cycle",
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = ">",
      path_display = { "smart" }, -- or truncate
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = {
          ["<C-d>"] = require("telescope.actions").delete_buffer,
        },
        i = {
          ["<C-k>"] = actions.move_selection_previous, -- move to prev result
          ["<C-j>"] = actions.move_selection_next, -- move to next result
          ["<C-q>"] = actions.send_selected_to_qflist,
          ["<c-enter>"] = "to_fuzzy_refine",
          -- custom_actions.open_trouble_qflist,
          -- ["<C-t>"] = trouble_telescope_sources.open,
        },
      },
    }
    -- Useful for easily creating commands
    local z_utils = require "telescope._extensions.zoxide.utils"
    -- local project_actions = require("telescope._extensions.project.actions")
    local builtin = require "telescope.builtin"
    telescope.setup {
      defaults = custom_telescope_theme,
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        zoxide = {
          prompt_title = "[ Walking on the shoulders of Techdeus ]",
          mappings = {
            default = {
              after_action = function(selection)
                print("Update to (" .. selection.z_score .. ") " .. selection.path)
              end,
            },
            ["<CR>"] = {
              keepinsert = true,
              action = function(selection)
                builtin.find_files { cwd = selection.path }
              end,
              after_action = function(selection)
                vim.cmd("cd " .. selection.path)
              end,
            },
            ["<C-s>"] = {
              before_action = function()
                print "before C-s"
              end,
              action = function(selection)
                vim.cmd.edit(selection.path)
              end,
            },
            -- Opens the selected entry in a new split
            ["<C-q>"] = { action = z_utils.create_basic_command "split" },
          },
        },
        project = {
          base_dirs = {
            "~/src/",
            "~/.config/",
          },
          --   hidden_files = true, -- default: false
          --   theme = "dropdown",
          --   order_by = "asc",
          --   search_by = "title",
          sync_with_nvim_tree = true, -- default false
          -- default for on_project_selected = find project files
          --   on_project_selected = function(prompt_bufnr)
          --     project_actions.change_working_directory(prompt_bufnr, false)
          --     -- require("harpoon.ui").nav_file(1)
          --   end,
        },
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          -- find command (defaults to `fd`)
          find_cmd = "rg",
        },
      },
    }
    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "file_browser")
    pcall(require("telescope").load_extension, "project")
    pcall(require("telescope").load_extension, "zoxide")
    pcall(require("telescope").load_extension, "media_files")
    -- pcall(require('telescope').load_extension, 'scope')
    local builtin = require "telescope.builtin"
    local map = vim.keymap
    map.set({ "n", "v" }, "<Leader>tc", "<cmd>Telescope commands<cr>", { desc = "Show Commands" })
    map.set("n", "<leader>tb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "FZF current buffer" })
    map.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    map.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    map.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    map.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    map.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    map.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    map.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    map.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    map.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    map.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    map.set("n", "<leader>sb", "<cmd>Telescope file_browser<cr>", { desc = "[S]earch File Browser" })
    map.set("n", "<leader>sG", "<cmd>Telescope git_files<cr>", { desc = "Git files" })
    map.set("n", "<leader>sR", "<cmd>Telescope oldfiles<cr>", { desc = "Old files" })
    map.set("n", "<leader>sp", "<cmd>Telescope project<cr>", { desc = "Project" })
    map.set("n", "<leader>scs", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" })
    map.set("n", "<leader>sm", "<cmd>Telescope man_pages<cr>", { desc = "Man pages" })
    map.set("n", "<leader>sn", "<cmd>Telescope notify<cr>", { desc = "Notifications" })
    map.set("n", "<leader>stt", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    -- Slightly advanced example of overriding default behavior and theme
    map.set("n", "<leader>ff", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = "[/] Fuzzily search in current buffer" })
    map.set("n", "<leader>s/", function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      }
    end, { desc = "[S]earch [/] in Open Files" })
    -- Shortcut for searching your Neovim configuration files
    map.set("n", "<leader>sn", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end, { desc = "[S]earch [N]eovim files" })
  end,
}
