require("bufferline").setup({
	options = {
		mode = "tabs",
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		show_tab_indicators = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = "NvimTree Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})
