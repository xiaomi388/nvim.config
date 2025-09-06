
" load packer
" lua require('plugins')
" augroup packer_user_config
"   autocmd!
"   autocmd BufWritePost plugins.lua source &lt;afile&gt; | PackerCompile augroup end
" 

lua require("config.lazy")

" load lua configs
lua << EOF
-- Recursively load all lua files in the config directory and its subdirectories
local function load_lua_configs(dir, prefix)
  for _, item in ipairs(vim.fn.readdir(dir)) do
    local full_path = dir .. '/' .. item
    if vim.fn.isdirectory(full_path) == 1 then
      -- If item is a directory, recurse into it
      load_lua_configs(full_path, prefix .. item .. '.')
    elseif item:match('%.lua$') then
      -- If item is a lua file, require it
      if item ~= 'lazy.lua' then
        -- print('Loading ' .. prefix .. item:gsub('%.lua$', ''))
        require(prefix .. item:gsub('%.lua$', ''))
      end
    end
  end
end

load_lua_configs(vim.fn.stdpath('config') .. '/lua/config', 'config.')
EOF

" load vim configs
for f in split(glob("$HOME/.config/nvim/vim/*.vim"), '\n')
    exe 'source' f
endfor
