"ssh remote clipboard shortcut (OSCYank)
vnoremap <leader>c "+y
let g:oscyank_term = 'default'
nnoremap <C-a> :let @+ = expand('%:p:~:.')<CR>:OSCYankRegister +<CR>

