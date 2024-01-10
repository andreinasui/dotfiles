local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local typescript = require("typescript")

local keymap = vim.keymap

-- enable keybinds for available lsp server
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
-- Expand native LSP client capabilities to use foldingRange
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- set debug log level to lsp
vim.lsp.set_log_level("info")

-- configure multiple servers
local servers = { "clangd", "cmake", "bashls", "html", "cssls", "pyright" }
for _, server in pairs(servers) do
	if server == "clangd" then
		lspconfig[server].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--background-index",
				"-j=4",
			},
		})
	else
		lspconfig[server].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end
end

--configure sonarlint
-- require("sonarlint").setup({
-- 	server = {
-- 		cmd = {
-- 			"sonarlint-language-server",
-- 			-- Ensure that sonarlint-language-server uses stdio channel
-- 			"-stdio",
-- 			"-analyzers",
-- 			-- paths to the analyzers you need, using those for python and java in this example
-- 			vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
-- 		},
-- 	},
-- 	filetypes = {
-- 		-- Tested and working
-- 		"cpp",
-- 	},
-- })

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure esbonio rst lsp
lspconfig.esbonio.setup({
	settings = {
		preview = {
			bind = "localhost",
			htttpPort = 7000,
		},
		sphinx = {
			pythonCommand = { "/home/andrei/.pyenv/versions/px13-py3-env" },
			buildCommand = { "sphinx-build", "-M", "html", "doc", "doc/build" },
		},
	},
})

-- configure emmet language server
-- lspconfig["emmet_ls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- })

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
