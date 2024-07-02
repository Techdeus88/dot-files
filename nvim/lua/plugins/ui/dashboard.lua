return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require "alpha.themes.dashboard"
    require "alpha.term"
    dashboard.section.terminal.command = vim.fn.stdpath "config" .. "/nvim-logo -t"
    dashboard.section.terminal.width = 70
    dashboard.section.terminal.height = 10
    dashboard.section.terminal.opts.redraw = true
    dashboard.section.terminal.opts.window_config.zindex = 1
    -- offset placment for screenshots
    dashboard.section.terminal.opts.window_config.col = math.floor((vim.o.columns - 70) / 2 + 20)
    -- vim.cmd [[autocmd! User AlphaClosed]]

    dashboard.section.buttons.val = {
      dashboard.button("ai", "    co-pilot", ":Copilot panel<CR>"),
      dashboard.button("c", "    config", ":Oil ~/.config/nvim/<CR>"),
      dashboard.button("o", "    cwd", ":Oil<CR>"),
      dashboard.button("l", "󰒲    lazy", ":Lazy<CR>"),
      dashboard.button("m", "󱌣    mason", ":Mason<CR>"),
      dashboard.button("lp", "󰄉    profile", ":Lazy profile<CR>"),
      dashboard.button("n", "    new file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("e", "    old files", ":Telescope oldfiles<CR>"),
      dashboard.button("f", "󰥨    find file", ":Telescope file_browser<CR>"),
      dashboard.button("g", "󰱼    find text", ":Telescope live_grep_args<CR>"),
      dashboard.button("p", "    open projects", ":Telescope project<CR>"),
      dashboard.button("h", "    browse git", ":Flog<CR>"),
      dashboard.button("q", "󰭿    quit", ":qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "Normal"
      button.opts.hl_shortcut = "Function"
    end
    dashboard.section.footer.opts.hl = "Special"

    dashboard.opts.layout = {
      dashboard.section.terminal,
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      dashboard.section.footer,
    }
    return dashboard
  end,
  config = function(_, dashboard)
    -- close lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    dashboard.config.opts.noautocmd = true
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local fortune = require "alpha.fortune"
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.header.val = "󱐋 " .. stats.count .. " plugins loaded in " .. ms .. "ms"
        dashboard.section.footer.val = fortune
        pcall(vim.cmd.AlphaRedraw)

        if vim.notify then
          vim.notify(
            "Vim keymaps, options, and commands are loaded and complete!",
            3,
            { title = "Config update", timeout = 3000 }
          )
        end
      end,
    })
  end,
}
