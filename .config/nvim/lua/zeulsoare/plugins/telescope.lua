local ok_telescope, telescope = pcall(require, "telescope")
if not ok_telescope then
	return
end

local ok_telescope_actions, actions = pcall(require, "telescope.actions")
if not ok_telescope_actions then
	return
end

local ok_trouble, trouble = pcall(require, "trouble.providers.telescope")
if not ok_trouble then
	vim.notify("Problems with requiring trouble telescope provider!", vim.log.levels.ERROR)
	return
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-t>"] = trouble.open_with_trouble,
			},
			n = {
				["<C-t>"] = trouble.open_with_trouble,
			},
		},
	},
	pickers = {
		diagnostics = {
			theme = "dropdown",
		},
	},
})

telescope.load_extension("fzf")
