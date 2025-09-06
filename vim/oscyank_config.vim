"ssh remote clipboard shortcut (OSCYank)
vnoremap <leader>c :OSCYankVisual<CR>
let g:oscyank_term = 'default'
nnoremap <C-a> :let @+ = expand('%:p:~:.')<CR>:OSCYankRegister +<CR>

