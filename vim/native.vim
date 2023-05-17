" native.vim contains native vim settings
filetype plugin indent on
syntax on
colorscheme tokyonight

" Tabs size
"set expandtab
set shiftwidth=4
set tabstop=4
"set mouse=a
set number
tnoremap <Esc> <C-\><C-n>

" relative number
:set relativenumber
:set rnu

" close quickfix list shortcut
augroup vimrcQfClose
    autocmd!
    autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
augroup END

" enable project settings
set exrc
set secure

"folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" auto reload current buffer
set autoread

"mosh color
"set notermguicolors

" Switch to the previous buffer
function! SwitchToPreviousBuffer()
    let previous_buffer = bufnr('#')
    execute 'buffer ' . previous_buffer
endfunction

" Create a custom mapping to trigger the function
nnoremap <C-p> :call SwitchToPreviousBuffer()<CR>
