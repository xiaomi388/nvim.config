local cwd = io.popen("pwd"):read("*all")
if string.find(cwd, "google3") then
	require'navigator'.setup({
		lsp = {
			disply_diagnostic_qf = false,
			diagnostic = {
				virtual_text = false
			},
			disable_lsp = {'gopls'},
			servers = {'ciderlsp'}
		}	
	})
else
	require'navigator'.setup({
		lsp = {
			disply_diagnostic_qf = false,
			diagnostic = {
				virtual_text = false
			}
		}	
	})
end


