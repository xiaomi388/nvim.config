return {
  "yetone/avante.nvim",
  enebaled = false,
  build = function()
    if vim.fn.has("win32") == 1 then
      return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    else
      return "make"
    end
  end,
  event = "VeryLazy",
  -- commit = "5b2a0e61189",
  opts = function()
    -- Get the current project path
    local project_path = vim.fn.getcwd()

    -- Default options
    local opts = {
      provider = "vertex_claude",
      providers = {
        ---@type AvanteSupportedProvider
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-5",
          timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          context_window = 128000, -- Number of tokens to send to the model for context
          extra_request_body = {
            temperature = 1,
            max_completion_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
            reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
        gemini = {
          model = "gemini-2.5-flash",
          model_names = {
            "gemini-2.5-pro",
            "gemini-2.5-flash",
          },
          timeout = 30000,
          context_window = 1048576,
          use_ReAct_prompt = true,
          extra_request_body = {
            generationConfig = {
              temperature = 0.35,
            },
          },
        },
        ---@type AvanteSupportedProvider
        vertex_claude = {
          endpoint = "https://us-east5-aiplatform.googleapis.com/v1/projects/yufanchen-rjl23p/locations/global/publishers/antrhopic/models",
          model_names = {
            "claude-sonnet-4-5",
            "claude-opus-4-1",
          },
          model = "claude-sonnet-4-5", -- "claude-opus-4-1",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
      },
      rag_service = {
        enabled = false,
        provider = "ollama",
        llm_model = "llama2",
        embed_model = "nomic-embed-text",
        endpoint = "http://192.168.9.1:11434",
        runner = "docker",
        llm = {
          provider = "ollama",
          endpoint = "http://192.168.9.1:11434",
          api_key = "",
          model = "llama2",
          extra = nil,
        },
        embed = {
          provider = "ollama",
          endpoint = "http://192.168.9.1:11434",
          api_key = "",
          model = "nomic-embed-text",
          extra = nil,
        },
        docker_extra_args = "",
      },
      file_selector = {
        provider = "telescope",
        provider_opts = {
          get_filepaths = function(params)
            local cwd = params.cwd
            local selected_filepaths = params.selected_filepaths
            local cmd = string.format("fdfind")
            local output = vim.fn.system(cmd)
            local filepaths = vim.split(output, "\n", { trimempty = true })
            return vim
              .iter(filepaths)
              :filter(function(filepath)
                return not vim.tbl_contains(selected_filepaths, filepath)
              end)
              :totable()
          end,
        },
      },
    }

    local provider = vim.env.AVANTE_PROVIDER
    if provider then
      print("MY_ENV_VAR is set: " .. provider)
      opts.provider = provider
    end

    -- Example: Check if the project path contains a specific folder name
    -- local cwd = io.popen("pwd"):read("*all")
    -- if string.find(cwd, "google3") then
    --   opts.mode = "legacy"
    --   opts.provider = "goose"
    --   opts.providers["goose"] = require("avante-goose").getProvider()
    --   require("avante").setup(opts)
    -- end

    return opts
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
