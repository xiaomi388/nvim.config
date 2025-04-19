-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- let navigator plugin take over the actions
  require('navigator.lspclient.mapping').setup({bufnr=bufnr, client=client})
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- navigator can't handle gd correctly.. this is stupid
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  ---- dap
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'D', '<cmd>lua require("dapui").eval()<CR>', opts)
  -- go auto import & format
  -- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
end

-- setup lspconfig
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local lspconfig = require('lspconfig')

local cwd = io.popen("pwd"):read("*all")
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
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
  
  lspconfig['gopls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      gopls = {
  		["local"] = "gke-internal.googlesource.com",
  		directoryFilters = {
              "-**/node_modules", -- Ignore node_modules at any depth.
              -- These contain no Go code.
              "-ansible",
              "-asset-mgmt",
              "-frontend",
              "-owners",
              "-sbom",
              -- There is no globbing, so we have to exclude bazel directories manually.
              "-bazel-bin",
              "-bazel-out",
              "-bazel-private-cloud",
              "-bazel-testlogs"
  		}
  	}
    }
  }
  
  lspconfig['beancount'].setup {
      on_attach = on_attach,
      capabilities = capabilities,
  	init_options = {
          journal_file = "~/Documents/Ledger/main.beancount",
      },
      cmd = { "beancount-language-server", "--stdio" }
  }
end


