local present_pairs, npairs = pcall(require, "nvim-autopairs")

if not present_pairs then
  return
end

local Rule = require "nvim-autopairs.rule"

npairs.setup {
  disable_filetype = { "TelescopePrompt", "vim" },
  -- specify a list of rules to add
  Rule(" ", " "):with_pair(function(options)
    local pair = options.line:sub(options.col - 1, options.col)
    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
  end),
  Rule("( ", " )")
    :with_pair(function()
      return false
    end)
    :with_move(function(options)
      return options.prev_char:match ".%)" ~= nil
    end)
    :use_key ")",
  Rule("{ ", " }")
    :with_pair(function()
      return false
    end)
    :with_move(function(options)
      return options.prev_char:match ".%}" ~= nil
    end)
    :use_key "}",
  Rule("[ ", " ]")
    :with_pair(function()
      return false
    end)
    :with_move(function(options)
      return options.prev_char:match ".%]" ~= nil
    end)
    :use_key "]",
}

