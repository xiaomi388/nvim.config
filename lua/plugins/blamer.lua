return {
  "APZelos/blamer.nvim",
  init = function()
    vim.g.blamer_enabled = 1
    vim.g.blamer_template = "<commit-short> • <author> • <committer-time> • <summary>"
    vim.g.blamer_date_format = "%m/%d/%Y"
  end,
}
