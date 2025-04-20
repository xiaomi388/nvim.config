-- put this in a file like `after/plugin/signs.lua`
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end
})
