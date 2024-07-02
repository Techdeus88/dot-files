return {
  "shaunsingh/nord.nvim",
  init = function()
    vim.g.nord_contrast = true
    vim.g.nord_cursorline_transparent = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = false
    vim.g.nord_italic = false
    vim.g.enable_sidebar_background = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold_vertical_split_line = true
    vim.g.nord_bold = false
    vim.g.nord_italic = true
    vim.g.nord_italic_comments = true
    vim.g.nord_underline = true
    vim.g.nord_uniform_status_lines = true
    vim.g.nord_cursor_line_number_background = true
  end,
  config = function()
    -- Load the color configuration
    require "configs.theme"
    -- Load the color scheme
    vim.g.colorscheme = "nord"
  end,
}
