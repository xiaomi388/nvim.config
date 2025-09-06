return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'polarmutex/git-worktree.nvim', version = '^2' },
  },
  config = function()
    local action_set = require('telescope.actions.set')

    require('telescope').setup {
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
        -- path_display = {
        --   "smart"
        -- }
      },
      pickers = {
		-- disable the "hacky" find picker because it's a bit slow.
        -- find_files = {
        --   attach_mappings = function(prompt_bufnr)
        --     action_set.select:enhance({
        --       post = function()
        --         vim.cmd(":normal! zx")
        --       end
        --     })
        --     return true
        --   end
        -- },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "ignore_case",
        },
      }
    }

    require('telescope').load_extension('fzf')
    require("telescope").load_extension("git_worktree")
	-- require("telescope").load_extension("frecency")
    require("telescope").load_extension("live_grep_args")

    -- require("frecency.config").setup {
    --   auto_validate = true,
    --   ignore_patterns = { "*/.git", "*/.git/*", "*/.DS_Store", "bazel-*/*", "*/vendor/*", "*/third_party/*" },
    -- }

    vim.api.nvim_create_user_command("LiveGrepInDir", function(opts)
      local dir = opts.args ~= "" and opts.args or vim.fn.expand("%:p:h")
      require("telescope").extensions.live_grep_args.live_grep_args({
        cwd = dir
      })
    end, { nargs = "?" })

    local Hooks = require("git-worktree.hooks")
    local config = require('git-worktree.config')
    local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

    Hooks.register(Hooks.type.SWITCH, function (path, prev_path)
      vim.notify("Moved from " .. prev_path .. " to " .. path)
      update_on_switch(path, prev_path)
    end)

    Hooks.register(Hooks.type.DELETE, function ()
      vim.cmd(config.update_on_change_command)
    end)
  end,
}

