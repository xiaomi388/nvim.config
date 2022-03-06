runtime tree.vim

" load packer
lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" lua config mapping
lua require('lsp')
lua require('dap_adapter')
lua require('treesitter')
lua require('autopair_config')
lua require('telescope_config')

filetype plugin indent on
syntax on
colorscheme tokyonight

" Tabs size
set expandtab
set shiftwidth=4
set tabstop=4
"set mouse=a
set number
tnoremap <Esc> <C-\><C-n>

" telescope sugar
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd :lua require'telescope'.extensions.dap.commands{}<CR>


" choose win
nmap - <Plug>(choosewin)

" dap
nnoremap <silent> <F4> :lua require('dapui').toggle()<CR>
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
autocmd FileType python          nnoremap <buffer> <leader>t  :lua require('dap-python').test_method()<CR>
autocmd FileType go          nnoremap <buffer> <leader>t  :lua require('dap-go').debug_test()<CR>
