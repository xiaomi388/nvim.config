require('nvim-tree').setup({
  git = {
	  ignore = false,
  },
  filters = {
	  dotfiles = false,
  },
  view = {
      preserve_window_proportions = true,
	  width = 50,
      mappings = {
          list = {
              { key = "<C-e>", action = ""},
              { key = "-", action = ""}
          }
      }
  }
})
