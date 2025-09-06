return {
  'ggandor/leap.nvim',
  dependencies = { "tpope/vim-repeat" },
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 'f',  '<Plug>(leap)')
    vim.keymap.set({'n', 'x', 'o'}, 'F',  '<Plug>(leap-backward)')
    vim.keymap.set({'n', 'x', 'o'}, 'gf', '<Plug>(leap-from-window)')
  end,
}

