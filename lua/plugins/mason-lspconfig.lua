return {
  "mason-org/mason-lspconfig.nvim",
  enabled = function()
	return false
    -- local cwd = io.popen("pwd"):read("*all")
    -- return not string.find(cwd, "google3")
  end,
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
