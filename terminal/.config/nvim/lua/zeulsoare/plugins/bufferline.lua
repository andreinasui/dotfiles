return {
  "akinsho/bufferline.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  version = "*",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
        numbers = "none",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        show_tab_indicators = false,
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    })
  end,
}
