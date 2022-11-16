require('nvim-tree').setup({
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
