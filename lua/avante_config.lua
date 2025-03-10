require('avante').setup({
	provider = "gemini",
	gemini = {
       model = "gemini-2.0-flash",
	},
	file_selector = {
		provider = "telescope",
        provider_opts = {
          ---@param params avante.file_selector.opts.IGetFilepathsParams
          get_filepaths = function(params)
            local cwd = params.cwd ---@type string
            local selected_filepaths = params.selected_filepaths ---@type string[]
            local cmd = string.format("fdfind")
            local output = vim.fn.system(cmd)
            local filepaths = vim.split(output, "\n", { trimempty = true })
            return vim
              .iter(filepaths)
              :filter(function(filepath)
                return not vim.tbl_contains(selected_filepaths, filepath)
              end)
              :totable()
          end
        }
	}
})
