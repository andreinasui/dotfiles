local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
	return
end

local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lspconfig then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		-- C/C++
		"clangd",
		"cmake",
		-- rust
		"rust_analyzer",
		-- Web dev
		"tsserver",
		"html",
		"cssls",
		"tailwindcss",
		-- Misc programming languages
		"lua_ls", -- lua lsp
		"bashls", -- bash lsp
		"pyright", -- python
		-- Misc filetypes lsp
		"jsonls",
		"yamlls",
		"texlab",
	},
	automatic_installation = true,
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"shellcheck", -- sh/bash linter
		"shfmt", -- sh/bash formatter
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"clang_format", -- c/c++ formatter
		"cmakelang", -- cmake formatter/linter
		"black", -- python formatter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
	sources = {
		...,
		require("typescript.extensions.null-ls.code-actions"),
	},
})
