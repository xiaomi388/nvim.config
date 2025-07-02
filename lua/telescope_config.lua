-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
local action_set = require('telescope.actions.set')

require('telescope').setup {
  -- https://github.com/nvim-telescope/telescope.nvim/issues/559
  defaults = {
	  vimgrep_arguments = {
		  "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--ignore-case"
	  },
	  dynamic_preview_title = true,
	  path_display = {
		  "smart"
	  }
  },
  pickers = {
    find_files = {
      attach_mappings = function(prompt_bufnr)
        action_set.select:enhance({
          post = function()
            vim.cmd(":normal! zx")
          end
        })
        return true
      end
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "ignore_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
--require('telescope').load_extension('vim_bookmarks')
require("telescope").load_extension("git_worktree")

require("telescope").load_extension("frecency")

require("frecency.config").setup {
  auto_validate = true,
  ignore_patterns = { "*/.git", "*/.git/*", "*/.DS_Store", "bazel-*/*", "*/vendor/*", "*/third_party/*" },
}

vim.api.nvim_create_user_command("LiveGrepInDir", function(opts)
  local dir = opts.args ~= "" and opts.args or vim.fn.expand("%:p:h")
  require("telescope").extensions.live_grep_args.live_grep_args({
    cwd = dir
  })
end, { nargs = "?" })
