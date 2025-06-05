return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      mason.setup()

      mason_lspconfig.setup({
        ensure_installed = {
          -- C/C++
          "clangd",
          "cmake",
          -- rust
          "rust_analyzer",
          -- Web dev
          "ts_ls",
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
      mason_tool_installer.setup({
        ensure_installed = {
          "prettier", -- prettier formatter
          "stylua", -- lua formatter
          "isort", -- python formatter
          "black", -- python formatter
          "pylint",
          "eslint_d",
        },
      })
    end,
  },
  -- formatting and linting
  {
    "nvimtools/none-ls.nvim", -- configure formatters & linters
    config = function()
      local null_ls = require("null-ls")

      -- for conciseness
      local formatting = null_ls.builtins.formatting -- to setup formatters
      local diagnostics = null_ls.builtins.diagnostics -- to setup linters
      local code_actions = null_ls.builtins.code_actions -- to setup code actions

      -- to setup format on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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
          -- formatting.rustfmt, -- rust formatter
          -- code actions
          -- code_actions.gitsigns,
          -- code_actions.shellcheck,
          -- code_actions.eslint_d.with({ -- js/ts linter
          --   -- only enable eslint if root has .eslintrc.js
          --   condition = function(utils)
          --     return utils.root_has_file(".eslintrc.json") -- change file extension if you use something else
          --       or utils.root_has_file(".eslintrc.js")
          --       or utils.root_has_file(".eslintrc.yaml")
          --   end,
          -- }),
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
                  async = false,
                  bufnr = bufnr,
                  timeout_ms = 5000,
                  -- filter = function(client)
                  --   return client.name == "null-ls"
                  -- end,
                })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      local mason_null_ls = require("mason-null-ls")
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
      })
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
