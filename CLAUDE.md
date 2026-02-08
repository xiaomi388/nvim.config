# Neovim Configuration Agent

You maintain Yufan Chen's Neovim configuration. Your job is to help debug issues, add plugins, modify keymaps, and keep the config clean and working.

---

## Config Architecture

**Entry point:** `init.vim`

The load order is:
1. `lua/config/lazy.lua` — bootstraps lazy.nvim plugin manager, sets `mapleader = "\\"`
2. All Lua files under `lua/config/` (recursively) — options, keymaps, autocmds
3. All `.vim` files under `vim/` (glob-sourced) — legacy vimscript configs

### Directory Layout

```
~/.config/nvim/
├── init.vim                     # Entry point (load order defined here)
├── lazy-lock.json               # lazy.nvim lockfile (auto-generated, gitignored)
├── stylua.toml                  # Lua formatter config
├── lua/
│   ├── config/
│   │   ├── lazy.lua             # lazy.nvim bootstrap + plugin spec imports
│   │   ├── options.lua          # Diagnostic signs
│   │   ├── keymaps.lua          # Custom commands (:Format) and keybindings
│   │   └── autocmds.lua         # (empty)
│   └── plugins/
│       └── *.lua                # lazy.nvim plugin specs (one per plugin)
├── vim/
│   ├── native.vim               # Native vim settings
│   ├── diagnostic.vim           # Diagnostic display config
│   ├── custom_hightlight.vim    # Custom highlight groups
│   ├── dap_config.vim           # Debug Adapter Protocol config
│   └── *.vim                    # Other vimscript configs
└── syntax/
    └── log.vim                  # Custom log file syntax highlighting
```

### Key Plugin List (lazy.nvim)

Core plugins managed via `lua/plugins/*.lua`:
- **telescope** — fuzzy finder
- **nvim-tree** — file explorer
- **treesitter** — syntax highlighting/parsing
- **lsp** (nvim-lspconfig) — LSP client setup
- **cmp** — autocompletion
- **conform** — formatting (`:Format` command)
- **avante** — AI assistant
- **trouble** — diagnostics list
- **bufferline** — buffer tabs
- **lualine** — statusline
- **which-key** — keymap discovery
- **snacks** — utility collection
- **dap** — debugging
- **leap** — motion
- **grug-far** — search and replace

---

## Testing Changes

### Non-Interactive Test (headless)

Always test config changes before considering them done:

```bash
# Check for startup errors
timeout 8 nvim --headless -c "qa!" 2>&1

# Check if a command exists
timeout 8 nvim --headless -c "command Format" -c "qa!" 2>&1

# Check loaded scripts
timeout 8 nvim --headless +"redir! > /tmp/nvim_scripts.txt" +"scriptnames" +"redir END" +"qa!" 2>/dev/null
cat /tmp/nvim_scripts.txt
```

---

## Guidelines

- **Always read a file before editing it.**
- **Test changes non-interactively** using the headless commands above.
- **One plugin per file** in `lua/plugins/` — each file returns a lazy.nvim plugin spec table.
- Do not modify `.gitignore` without asking.
