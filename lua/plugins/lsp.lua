return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Keymaps for diagnostics
    -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { noremap = true, silent = true })
    -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })
    -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
    -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { noremap = true, silent = true })
    vim.keymap.set("n", "gL", vim.diagnostic.open_float, { noremap = true, silent = true })

    -- local on_attach = function(client, bufnr)
    --   local bufopts = { noremap = true, silent = true, buffer = bufnr }
    --   -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    --   -- vim.keymap.set("n", "gri", vim.lsp.buf.implementation, bufopts)

    --   -- Auto-format go files on save
    --   -- replaced by conform.lua
    --   -- if client.name == "gopls" then
    --   --   vim.api.nvim_create_autocmd("BufWritePre", {
    --   --     buffer = bufnr,
    --   --     command = "lua require('go.format').goimport()",
    --   --   })
    --   -- end
    -- end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")

    -- Setup servers based on current directory
    local cwd = vim.fn.getcwd()
    if string.find(cwd, "google3") then
      return
    end

    local servers = { "rust_analyzer", "tsserver", "clangd", "golangci_lint_ls", "pyright", "gopls", "stylua" }
    for _, server_name in ipairs(servers) do
      local server_opts = {
        capabilities = capabilities,
      }
      if server_name == "gopls" then
        server_opts.settings = {
          gopls = {
            usePlaceholders = false,
          },
        }
      end
      lspconfig[server_name].setup(server_opts)
    end

    lspconfig.beancount.setup({
      capabilities = capabilities,
      init_options = {
        journal_file = vim.fn.expand("~/Documents/Ledger/main.beancount"),
      },
    })
  end,
}
