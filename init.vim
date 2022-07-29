" load packer
lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" load lua configs
lua << EOF
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua', [[v:val =~ '\.lua$']])) do
  require(file:gsub('%.lua$', ''))
end
EOF

" load vim configs
for f in split(glob("$HOME/.config/nvim/vim/*.vim"), '\n')
    exe 'source' f
endfor

