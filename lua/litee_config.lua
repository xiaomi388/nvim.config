require('litee.lib').setup({
    panel = {
        orientation = "bottom",
        panel_size  = 10
    }
})

require('litee.bookmarks').setup({})

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', 'mm', '<cmd>LTCreateBookmark<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-m>', '<cmd>LTPanel<CR>', opts)
