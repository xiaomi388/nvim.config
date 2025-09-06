return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.del("n", "<C-e>", { buffer = bufnr })
    end

    require('nvim-tree').setup({
      on_attach = my_on_attach,
      git = {
        ignore = false,
      },
      filters = {
        dotfiles = false,
      },
      respect_buf_cwd = true,
    })
  end,
}

