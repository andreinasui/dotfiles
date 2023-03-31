require("lspsaga").setup({
	move_in_saga = { prev = "<C-j>", next = "<C-k>" },
	finder = {
		max_height = 0.5,
		min_width = 30,
		force_max_height = false,
		keys = {
			jump_to = "p",
			expand_or_jump = "o",
			vsplit = "v",
			split = "i",
			tabe = "t",
			tabnew = "r",
			quit = { "q", "<ESC>" },
			close_in_preview = "<ESC>",
		},
	},
	definition = {
		edit = { "<C-c>o", "<CR>" },
		vsplit = "<C-c>v",
		split = "<C-c>i",
		tabe = "<C-c>t",
		quit = { "q", "<ESC>" },
	},
})
