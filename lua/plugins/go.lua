-- local on_attach = function(client, bufnr)
--   local bufopts = { noremap = true, silent = true, buffer = bufnr }
--   vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
--   vim.keymap.set("n", "gri", vim.lsp.buf.implementation, bufopts)
-- end
-- 
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  "ray-x/go.nvim",
  enabled = function()
    local cwd = io.popen("pwd"):read("*all")
    return not string.find(cwd, "google3")
  end,
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    -- lsp_keymaps = false,
    -- other options
    -- lsp_cfg = false,
  },
}
