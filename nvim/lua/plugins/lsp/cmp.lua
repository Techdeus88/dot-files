local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

-- AutoCompletion configuration
return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    build = (function()
      if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "antosha417/nvim-lsp-file-operations",
        config = true,
      },
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
      "hrsh7th/cmp-emoji", -- add cmp source as dependency of cmp
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim", -- vs-code like pictograms
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      require("luasnip.loaders.from_vscode").lazy_load()

      -- cmp.setup.cmdline("/", {
      -- 	mapping = cmp.mapping.preset.cmdline(),
      -- 	sources = {
      -- 		{ name = "buffer" },
      -- 	},
      -- })
      -- cmp.setup.cmdline(":", {
      -- 	mapping = cmp.mapping.preset.cmdline(),
      -- 	sources = cmp.config.sources({
      -- 		{ name = "path" },
      -- 		{
      -- 			name = "cmdline",
      -- 			option = {
      -- 				ignore_cmds = { "man", "!" },
      -- 			},
      -- 		},
      -- 	}),
      -- })
      luasnip.config.setup {}
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<C-y>"] = cmp.mapping.confirm { select = true },
          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
          ["<Tab>"] = function(fallback)
            if not cmp.mapping.select_next_item() then
              if vim.bo.buftype ~= "prompt" and has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if not cmp.mapping.select_prev_item() then
              if vim.bo.buftype ~= "prompt" and has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          end,
          ["<C-Space>"] = cmp.mapping.complete {},
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 }, -- For luasnip users.
        }, {
          { name = "buffer", priority = 500 },
          { name = "path", priority = 500 },
          { name = "emoji", priority = 250 },
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format {
              mode = "symbol_text",
              maxwidth = 50,
              ellipsis_char = "...",
            }(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
          end,
          expandable_indicator = true,
        },
      }
    end,
  },
}
