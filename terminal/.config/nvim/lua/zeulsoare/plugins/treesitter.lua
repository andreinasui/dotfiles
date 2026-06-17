return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          -- Enable treesitter highlighting and disable regex syntax
          pcall(vim.treesitter.start)
          -- Enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
      local ensureInstalled = {
        "all",
        -- "lua",
        -- "python",
        -- "typescript",
        -- "c++",
        -- "c",
        -- "rust",
        -- ... your parsers
      }
      local alreadyInstalled = require("nvim-treesitter.config").get_installed()
      local parsersToInstall = vim
        .iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
      require("nvim-treesitter").install(parsersToInstall)
    end,
    -- config = function()
    --   local treesitter = require("nvim-treesitter.configs")

    --   treesitter.setup({
    --     modules = {},
    --     -- ensure these language parsers are installed
    --     ensure_installed = "all",
    --     sync_install = false,
    --     ignore_install = { "ipkg" },
    --     refactor = {
    --       highlight_definitions = {
    --         enable = true,
    --         -- Set to false if you have an `updatetime` of ~100.
    --         clear_on_cursor_move = true,
    --       },
    --       highlight_current_scope = { enable = false },
    --       smart_rename = {
    --         enable = true,
    --         keymaps = {
    --           smart_rename = "grr",
    --         },
    --       },
    --       navigation = {
    --         enable = false,
    --         keymaps = {
    --           goto_definition_lsp_fallback = "gnd",
    --           list_definitions = "gnD",
    --           list_definitions_toc = "gO",
    --           goto_next_usage = "<a-*>",
    --           goto_previous_usage = "<a-#>",
    --         },
    --       },
    --     },
    --     -- enable syntax highlighting
    --     highlight = {
    --       enable = true,
    --       additional_vim_regex_highlighting = false,
    --     },
    --     textobjects = { enable = true },
    --     -- enable indentation
    --     indent = { enable = true },
    --     -- enable autotagging (w/ nvim-ts-autotag plugin)
    --     autotag = { enable = true },
    --     -- Automatically install missing parsers when entering buffer
    --     -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    --     auto_install = true,
    --   })
    -- end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    branch = "main",
  },
  {
    -- hyprlang treesitter
    {
      "luckasRanarison/tree-sitter-hyprlang",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        vim.filetype.add({
          pattern = { ["hypr.*.conf"] = "hyprlang", [".*.hl"] = "hyprlang" },
        })
      end,
    },
  },
  {
    -- kitty treesitter
    "fladson/vim-kitty",
    ft = "kitty",
    version = "*", -- You can select a tagged version
  },
  {
    -- log file highlighting
    "fei6409/log-highlight.nvim",
    config = function()
      require("log-highlight").setup({})
    end,
  },
}
