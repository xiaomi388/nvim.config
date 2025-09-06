return {
  "stevearc/conform.nvim",
  enabled = function()
    local cwd = io.popen("pwd"):read("*all")
    return not string.find(cwd, "google3")
  end,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      go = { "goimports", "gofmt" },
	  yaml = { "yamlfix" },
    },
    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_format = "fallback",
    -- },
  },
}
