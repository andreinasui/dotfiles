local lazy_stats = require("lazy").stats()
local plugins_number = function()
	if lazy_stats then
		return string.format("  %d plugins  ", lazy_stats.count)
	else
		return ""
	end
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[        /\          /\          /\       ]],
	[[     /\//\\/\    /\//\\/\    /\//\\/\    ]],
	[[  /\//\\\///\\/\//\\\///\\/\//\\\///\\/\ ]],
	[[ //\\\//\/\\///\\\//\/\\///\\\//\/\\///\\]],
	[[ \\//\/                            \/\\//]],
	[[  \/                                  \/ ]],
	[[  /\                                  /\ ]],
	[[ //\\  Neovim IDE with LSP and DAP   //\\]],
	[[ \\//                                \\//]],
	[[  \/                                  \/ ]],
	[[  /\                                  /\ ]],
	[[ //\\/\                            /\//\\]],
	[[ \\///\\/\//\\\///\\/\//\\\///\\/\//\\\//]],
	[[  \/\\///\\\//\/\\///\\\//\/\\///\\\//\/ ]],
	[[      \/\\//\/    \/\\//\/    \/\\//\/   ]],
	[[         \/          \/          \/      ]],
}

dashboard.section.buttons.val = {
	dashboard.button("<leader>ff", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("<leader>fo", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("<leader>fs", "  Find text", ":Telescope live_grep_args <CR>"),
	dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
	-- Number of plugins
	-- local total_plugins = plugins_number
	local datetime = os.date("%d-%m-%Y %H:%M:%S")
	local plugins_text = plugins_number()
		.. "   v"
		.. vim.version().major
		.. "."
		.. vim.version().minor
		.. "."
		.. vim.version().patch
		.. "   "
		.. datetime

	return plugins_text
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
require("alpha").setup(dashboard.opts)
