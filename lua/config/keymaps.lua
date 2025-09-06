vim.api.nvim_create_user_command("Format", function()
  require("conform").format({ async = false, lsp_fallback = true })
end, {})

-- <leader>th will flip inlay hint on/off for the current buffer
vim.keymap.set('n', '<leader>th', function()
  local buf = 0
  local new_state = not vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
  vim.lsp.inlay_hint.enable(buf, new_state)
end, { desc = 'Toggle inlay hints' })
