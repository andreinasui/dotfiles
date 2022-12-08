local ok, ufo = pcall(require, "ufo")
if not ok then
	vim.notify("Problems with requiring ufo plugin", vim.log.levels.ERROR)
	return
end

ufo.setup()
