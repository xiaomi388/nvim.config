
" load packer
" lua require('plugins')
" augroup packer_user_config
"   autocmd!
"   autocmd BufWritePost plugins.lua source &lt;afile&gt; | PackerCompile augroup end
" 

lua require("config.lazy")

" load lua configs
lua << EOF
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/config', [[v:val =~ '\.lua$']])) do
  if file ~= 'lazy.lua' then
    require('config.' .. file:gsub('%.lua$', ''))
  end
end
require("config.options")
EOF

" load vim configs
for f in split(glob("$HOME/.config/nvim/vim/*.vim"), '\n')
    exe 'source' f
endfor
