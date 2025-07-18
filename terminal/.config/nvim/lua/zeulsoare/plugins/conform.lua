return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black", "ruff_format", stop_after_first = true },
      cpp = { "clang-format" },
      c = { "clang-format" },
      cmake = { "cmake_format" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return {
        lsp_format = "fallback",
        timeout_ms = 2000,
      }
    end,
  },
}
