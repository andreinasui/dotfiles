local ok, saga = pcall(require, "lspsaga")
if not ok then
	return
end

saga.init_lsp_saga({
	move_in_saga = { prev = "<C-j>", next = "<C-k>" },
	code_action_lightbulb = {
		enable = true,
		enable_in_insert = false,
		cache_code_action = true,
		sign = true,
		update_time = 150,
		sign_priority = 20,
		virtual_text = true,
	},
	finder_action_keys = {
		open = { "o", "<CR>" },
		vsplit = "v",
		split = "i",
		tabe = "t",
		quit = { "q", "<ESC>" },
	},
	definition_action_keys = {
		edit = { "<C-c>o", "<CR>" },
		vsplit = "<C-c>v",
		split = "<C-c>i",
		tabe = "<C-c>t",
		quit = { "q", "<ESC>" },
	},
})
