return {
  "yetone/avante.nvim",
  build = function()
    if vim.fn.has("win32") == 1 then
      return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    else
      return "make"
    end
  end,
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "gemini",
    providers = {
      gemini = {
        model = "gemini-2.5-pro",
        timeout = 200000,
        max_tokens = 330480,
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000,
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
        end
      },
    },
  },
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
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

