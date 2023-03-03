require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
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
