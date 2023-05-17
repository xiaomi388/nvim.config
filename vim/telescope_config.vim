if getcwd() =~# "google3"
	" do something
	nnoremap <leader>ff <cmd>Telescope codesearch find_files<cr>trait:citc<cr>
	nnoremap <leader>fg <cmd>Telescope codesearch find_query<cr>
	nnoremap <leader>fr <cmd>Telescope citc modified<cr>
	nnoremap <leader>fw <cmd>Telescope citc workspaces<cr>
	"nnoremap <leader>ff <cmd>Telescope find_files<cr>
	"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
else
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fd :lua require'telescope'.extensions.dap.commands{}<CR>
endif

nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>fs <cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>


