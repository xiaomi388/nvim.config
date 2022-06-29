require('go').setup({
    verbose = true,
    log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
    dap_debug_gui = false,
    dap_debug_vt = false,
    dap_debug = false,
    dap_debug_keymap = false,
})

-- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

