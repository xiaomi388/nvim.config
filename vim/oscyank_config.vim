"ssh remote clipboard shortcut (OSCYank)
" Detect macOS
if has("macunix")
  vnoremap <leader>c "+y<CR>
else
  vnoremap <leader>c :OSCYankVisual<CR>
endif
let g:oscyank_term = 'default'
nnoremap <C-a> :let @+ = expand('%:p:~:.')<CR>:OSCYankRegister +<CR>


