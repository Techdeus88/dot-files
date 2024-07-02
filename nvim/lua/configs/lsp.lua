local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>rs", ":LspRestart<CR>", "[R]estart")

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
        end,
      })
    end
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local servers = {
  tsserver = {
    filetypes = {
      "typescript.tsx",
      "javascript.jsx",
      "javascript",
      "typescriptreact",
      "javascriptreact",
      "typescript",
    },
  },
  emmet_ls = {
    filetypes = {
      "html",
      "css",
      "sass",
      "scss",
      "less",
      "svelte",
    },
  },
  eslint = {
    root_dir = lspconfig.util.root_pattern(".eslintrc.js", ".eslintrc.json", "package.json"),
    filetypes = {
      "javascript",
      "typescript",
      "vue",
      "astro",
      "svelte",
      "typescript.tsx",
      "javascript.jsx",
      "typescriptreact",
      "javascriptreact",
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = { globals = { "vim" }, disable = { "missing-fields" } },
      },
    },
    filetypes = {
      "lua",
    },
  },
}

require("mason").setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "tsserver",
  "html",
  "cssls",
  "lua_ls",
  "emmet_ls",
  "eslint",
  "jsonls",
  "lua_ls",
  "pyright",
  "tailwindcss",
  "rust_analyzer",
  "gopls",
})
vim.list_extend(ensure_installed, {
  "black",
  "eslint_d",
  "flake8",
  "gofumpt",
  "goimports",
  "gomodifytags",
  "isort",
  "prettierd",
  "stylelint",
  "stylua",
  "pylint",
  "mypy",
  "autopep8",
  "autoflake",
})
require("mason-tool-installer").setup {
  ensure_installed = ensure_installed,
  auto_update = true,
  run_on_start = true,
  integrations = {
    ["mason-lspconfig"] = true,
    ["mason-nvim-dap"] = true,
    ["mason-null-ls"] = false,
  },
}
require("mason-lspconfig").setup {
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      require("lspconfig")[server_name].setup(server)
    end,
  },
  automatic_installation = true,
}
