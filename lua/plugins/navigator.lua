return {
  "ray-x/navigator.lua",
  enabled = function()
	return false
    -- local cwd = io.popen("pwd"):read("*all")
    -- return not string.find(cwd, "google3")
  end,
  dependencies = {
    { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    { "neovim/nvim-lspconfig" },
  },
  config = function()
    require("navigator").setup({
      lsp = {
        display_diagnostic_qf = false,
        disable_lsp = "all",
        format_on_save = false,
        diagnostic = {
          virtual_text = false,
        },
      },
    })

	vim.keymap.set('n', 'gri', function()
	  require('navigator.implementation').implementation(false, { timeout = 50000 })
	end, {
	  desc   = 'Go to Implementation (50s timeout)',
	  noremap = true,
	  silent  = true,
	})
  end,
}
