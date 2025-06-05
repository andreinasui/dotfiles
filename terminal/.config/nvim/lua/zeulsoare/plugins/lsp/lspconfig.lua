-- Hyprlang LSP
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
      { "nvimdev/lspsaga.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      -- local typescript = require("typescript")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

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

          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          -- typescript specific keymaps (e.g. rename file and update imports)
          -- if client.name == "tsserver" then
          --   keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
          --   keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports
          --   keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables
          -- end
        end,
      })

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- set debug log level to lsp
      vim.lsp.set_log_level("warn")

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["emmet_ls"] = function()
          -- configure emmet language server
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,
        ["hyprls"] = function()
          lspconfig["hyprls"].setup({
            capabilities = capabilities,
            filetypes = { "hyprland" },
          })
        end,
        ["lua_ls"] = function()
          -- configure lua server (with special settings)
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
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
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      { "echasnovski/mini.icons", opts = {} }, -- optional
    },
    config = function()
      require("lspsaga").setup({
        move_in_saga = { prev = "<C-j>", next = "<C-k>" },
        finder = {
          max_height = 0.5,
          min_width = 30,
          force_max_height = false,
          default = "def+imp+ref",
          keys = {
            jump_to = "p",
            expand_or_jump = "o",
            vsplit = "v",
            split = "i",
            tabe = "t",
            tabnew = "r",
            quit = { "q", "<ESC>" },
            close_in_preview = "<ESC>",
          },
        },
        definition = {
          edit = { "<C-c>o", "<CR>" },
          vsplit = "<C-c>v",
          split = "<C-c>i",
          tabe = "<C-c>t",
          quit = { "q", "<ESC>" },
        },
        symbol_in_winbar = {
          enable = true,
          separator = "  ",
          ignore_patterns = {},
          hide_keyword = true,
          show_file = true,
          folder_level = 2,
          respect_root = false,
          color_mode = true,
        },
      })
    end,
  },
}
