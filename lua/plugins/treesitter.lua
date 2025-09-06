return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = {'go', 'python', 'lua', 'vim', 'vimdoc', 'query', 'javascript', 'typescript', 'c', 'rust'},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}

