local cwd = io.popen("pwd"):read("*all")
if not string.find(cwd, "google3") then
	do return end
end

require("harpoon").setup({
	global_settings = {
		mark_branch = true,
	},
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    }
})

require("telescope").load_extension('harpoon')
