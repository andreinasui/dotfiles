require("lspsaga").setup({
	move_in_saga = { prev = "<C-j>", next = "<C-k>" },
	finder = {
		open = { "o", "<CR>" },
		vsplit = "v",
		split = "i",
		tabe = "t",
		quit = { "q", "<ESC>" },
	},
	definition = {
		edit = { "<C-c>o", "<CR>" },
		vsplit = "<C-c>v",
		split = "<C-c>i",
		tabe = "<C-c>t",
		quit = { "q", "<ESC>" },
	},
})
