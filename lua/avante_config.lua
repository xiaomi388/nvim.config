require('avante').setup({
	provider = "openai",
	openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      temperature = 0,
      max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
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
