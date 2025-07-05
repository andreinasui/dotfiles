return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { { "mason-org/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
    opts = {
      automatic_enable = true,
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
        "pyright", -- python lsp
        -- Misc filetypes lsp
        "jsonls",
        "yamlls",
        "texlab",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "ruff", -- python formatter and linter
        "black", -- python formatter
        "mypy", -- python linter
        "stylua", -- lua formatter and linter
        "clang-format", -- clang-format
        "cmakelang",
        "shfmt",
        "prettier",
      },
    },
  },
}
