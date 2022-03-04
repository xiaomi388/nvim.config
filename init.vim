" load packer
lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" lua config mapping
lua require('lsp')
lua require('cmp-config')

filetype plugin indent on
syntax on
colorscheme tokyonight

" Tabs size
set expandtab
set shiftwidth=4
set tabstop=4
