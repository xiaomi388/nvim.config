
return {
  "ray-x/navigator.lua",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    { "neovim/nvim-lspconfig" },
  },
  config = function()
    require("navigator").setup({
      lsp = {
        display_diagnostic_qf = false,
        disable_lsp = "all",
        diagnostic = {
          virtual_text = false,
        },
      },
    })
  end,
}

