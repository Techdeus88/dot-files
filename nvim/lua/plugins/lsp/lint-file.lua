return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>fl",
      function()
        require("lint").try_lint()
      end,
      mode = "n",
      desc = "[L]int buffer",
    },
  },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "flake8", "pylint" },
      css = { "stylelint" },
      lua = "luacheck",
    }

    local eslint = lint.linters.eslint_d
    eslint.args = {
      "--no-warn-ignored",
      "--format",
      "json",
      "--stdin",
      "--stdin-filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }
    -- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    -- 	group = lint_augroup,
    -- 	callback = function()
    -- 		lint.try_lint()
    -- 	end,
    -- })
  end,
}
