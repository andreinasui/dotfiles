local ok, saga = pcall(require, "lspsaga")
if not ok then
	return
end

saga.init_lsp_saga({
	move_in_saga = { prev = "<C-j>", next = "<C-k>" },
	finder_action_keys = {
		open = "<CR>",
	},
	definition_action_keys = {
		edit = "<CR>",
	},
})
