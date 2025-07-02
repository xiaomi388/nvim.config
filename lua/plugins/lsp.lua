
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "ray-x/go.nvim", -- For go.format
    "ray-x/navigator.lua",
  },
  config = function()
    -- Keymaps for diagnostics
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap=true, silent=true })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true })
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { noremap=true, silent=true })

    local on_attach = function(client, bufnr)
      local bufopts = { noremap=true, silent=true, buffer = bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

      -- Auto-format go files on save
      if client.name == "gopls" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "lua require('go.format').goimport()",
        })
      end
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig')

    -- Setup servers based on current directory
    local cwd = vim.fn.getcwd()
    if string.find(cwd, "google3") then
      local servers = { 'ciderlsp', 'analysislsp' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end
    else
      local servers = { 'rust_analyzer', 'ts_ls', 'clangd', 'golangci_lint_ls', 'pyright' }
      for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      lspconfig.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            ["local"] = "gke-internal.googlesource.com",
            directoryFilters = {
              "-**/node_modules",
              "-ansible",
              "-asset-mgmt",
              "-frontend",
              "-owners",
              "-sbom",
              "-bazel-bin",
              "-bazel-out",
              "-bazel-private-cloud",
              "-bazel-testlogs",
            },
          },
        },
      }

      lspconfig.beancount.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          journal_file = vim.fn.expand("~/Documents/Ledger/main.beancount"),
        },
      }
    end
  end,
}

