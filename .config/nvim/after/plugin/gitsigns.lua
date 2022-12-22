local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
	vim.notify("Problems with gitsigns!")
	return
end

gitsigns.setup()
