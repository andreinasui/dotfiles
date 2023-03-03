-- For default mappings see:
-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
require("nvim-tree").setup({
	renderer = {
		highlight_git = true,
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "+",
					arrow_open = "-",
				},
			},
		},
	},
	filters = {
		dotfiles = false,
		custom = {},
		exclude = {},
	},
	git = {
		ignore = false,
	},
	actions = {
		open_file = {
			window_picker = {
				enable = true,
			},
		},
	},
	view = {
		adaptive_size = false,
		mappings = {
			list = {
				-- unbind default cd keybind
				{ key = "<C-]>", action = "" },
				-- bind new cd keybind
				{ key = "<C-o>", action = "cd" },
			},
		},
	},
})
