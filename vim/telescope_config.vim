if getcwd() =~# "google3"
	" do something
	"nnoremap <leader>ff <cmd>Telescope codesearch find_files<cr>
	nnoremap <leader>fc <cmd>Telescope codesearch find_query<cr>
	nnoremap <leader>fr <cmd>Telescope citc modified<cr>
	nnoremap <leader>fw <cmd>lua require('neocitc').pick_workspace()<CR>
	"nnoremap <leader>ff <cmd>Telescope find_files<cr>
	"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
else
	nnoremap <leader>fd <cmd>LiveGrepInDir<CR>
	nnoremap <leader>fw <cmd>lua require('telescope').extensions.git_worktree.git_worktree()<cr>
endif

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>fs <cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>

