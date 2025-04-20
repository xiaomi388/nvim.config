local cwd = io.popen("pwd"):read("*all")
if string.find(cwd, "google3") then
	require'navigator'.setup({
		lsp = {
			display_diagnostic_qf = false,
			diagnostic = {
				virtual_text = false
			},
			disable_lsp = 'all',
			servers = {'ciderlsp'}
		}	
	})
else
	require'navigator'.setup({
		lsp = {
			display_diagnostic_qf = false,
			disable_lsp = 'all',
			diagnostic = {
				virtual_text = false
			}
		},
		icons = {
			icons = true,
			diagnostic_warn = "",
			diagnostic_hint = "",
			diagnostic_err = "",
			diagnostic_info = "",
		}
	})
end


