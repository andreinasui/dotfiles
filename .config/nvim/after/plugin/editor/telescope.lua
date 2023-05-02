local telescope = require("telescope")

local tele_actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")
local trouble = require("trouble.providers.telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = tele_actions.move_selection_previous,
				["<C-j>"] = tele_actions.move_selection_next,
				["<C-q>"] = tele_actions.send_selected_to_qflist + tele_actions.open_qflist,
				["<C-x>"] = trouble.open_with_trouble,
			},
			n = {
				["<C-x>"] = trouble.open_with_trouble,
			},
		},
		set_env = { COLORTERM = "truecolor" },
	},
	pickers = {
		diagnostics = {
			theme = "dropdown",
		},
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			-- define mappings, e.g.
			mappings = { -- extend mappings
				i = {
					["<C-q>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
			-- ... also accepts theme settings, for example:
			-- theme = "dropdown", -- use dropdown theme
			-- theme = { }, -- use own theme spec
			-- layout_config = { mirror=true }, -- mirror preview pane}
		},
	},
})

telescope.load_extension("live_grep_args")
telescope.load_extension("fzf")
