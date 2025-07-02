-- local cwd = io.popen("pwd"):read("*all")
-- if string.find(cwd, "google3") then
-- 	do return end
-- end

require('avante').setup({
  provider = 'gemini',
  providers = {
    gemini = {
      model = "gemini-2.5-pro",
      -- model = "gemini-2.5-flash-preview-05-20",
      timeout = 200000, -- Timeout in milliseconds
  	  max_tokens = 330480,
    },
  },
  rag_service = { -- RAG Service configuration
    enabled = false, -- Enables the RAG service
    -- host_mount = "/usr/local/google/home/yufanchen/private-cloud/main", -- Host mount path for the rag service (Docker will mount this path)
	provider = "ollama",
	llm_model = "llama2",
	embed_model = "nomic-embed-text",
	endpoint = "http://192.168.9.1:11434",
    runner = "docker", -- Runner for the RAG service (can use docker or nix)
    llm = { -- Language Model (LLM) configuration for RAG service
      provider = "ollama", -- LLM provider
      endpoint = "http://192.168.9.1:11434", -- LLM API endpoint
      api_key = "", -- Environment variable name for the LLM API key
      model = "llama2", -- LLM model name
      extra = nil, -- Additional configuration options for LLM
    },
    embed = { -- Embedding model configuration for RAG service
      provider = "ollama", -- Embedding provider
      endpoint = "http://192.168.9.1:11434", -- Embedding API endpoint
      api_key = "", -- Environment variable name for the LLM API key
      model = "nomic-embed-text", -- Embedding model name
      extra = nil, -- Additional configuration options for the embedding model
    },
    docker_extra_args = "", -- Extra arguments to pass to the docker command
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

