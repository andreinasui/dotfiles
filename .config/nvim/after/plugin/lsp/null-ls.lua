-- import null-ls plugin safely
local null_ls = require("null-ls")

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local code_actions = null_ls.builtins.code_actions -- to setup code actions

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  formatters
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettier.with({
			extra_args = { "--trailing-comma none" },
		}), -- js/ts formatter
		formatting.shfmt, -- sh, bash formatter
		formatting.stylua, -- lua formatter
		formatting.clang_format.with({ -- c/c++ formatter
			-- only enable if root has .clang-format
			condition = function(utils)
				return utils.root_has_file(".clang-format") or utils.root_has_file("_clang-format")
			end,
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		}),
		formatting.cmake_format, -- cmake formatter/linter
		formatting.black, -- python formatter
		formatting.xmlformat, -- xml formatter
		-- code actions
		-- code_actions.gitsigns,
		code_actions.shellcheck,
		code_actions.eslint_d.with({ -- js/ts linter
			-- only enable eslint if root has .eslintrc.js
			condition = function(utils)
				return utils.root_has_file(".eslintrc.json") -- change file extension if you use something else
					or utils.root_has_file(".eslintrc.js")
					or utils.root_has_file(".eslintrc.yaml")
			end,
		}),
		-- linters
		diagnostics.cmake_lint, -- cmake linter
		-- diagnostics.eslint_d.with({ -- js/ts linter
		-- 	-- only enable eslint if root has .eslintrc.js
		-- 	condition = function(utils)
		-- 		return utils.root_has_file(".eslintrc.json") -- change file extension if you use something else
		-- 			or utils.root_has_file(".eslintrc.js")
		-- 			or utils.root_has_file(".eslintrc.yaml")
		-- 	end,
		-- }),
		-- require("typescript.extensions.null-ls.code-actions"),
		diagnostics.cpplint,
	},
	-- on_init = function(new_client, _)
	-- 	new_client.offset_encoding = "utf-32"
	-- end,
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						timeout_ms = 5000,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
