-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = (function()
    -- import your plugins
    local specs = {}
    local function module_exists(name)
      -- Detect Lua modules on the runtimepath, including directories without init.lua
      -- e.g., lua/plugins/*.lua should be treated as a module "plugins" for lazy's import
      local sep_name = name:gsub("%.", "/")

      -- 1) Direct module files or init.lua in a folder
      local candidates = {
        "lua/" .. sep_name .. ".lua",
        "lua/" .. sep_name .. "/init.lua",
      }
      for _, pat in ipairs(candidates) do
        local files = vim.api.nvim_get_runtime_file(pat, true)
        if files and #files > 0 then
          return true
        end
      end

      -- 2) Any Lua files inside the module directory (e.g. lua/plugins/*.lua)
      local dir_glob = "lua/" .. sep_name .. "/*.lua"
      local dir_files = vim.api.nvim_get_runtime_file(dir_glob, true)
      if dir_files and #dir_files > 0 then
        return true
      end

      -- 3) Fallback to Lua/C search paths for completeness
      if package.searchpath(name, package.path) then
        return true
      end
      if package.searchpath(name, package.cpath) then
        return true
      end
      return false
    end
    if module_exists("plugins") then
      table.insert(specs, { import = "plugins" })
    end
    if module_exists("plugins.google") then
      table.insert(specs, { import = "plugins.google" })
    end
    return specs
  end)(),
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
