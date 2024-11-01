return {
  "norcalli/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      "scss",
      "sass",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    }, {
      names = false,
      rgb_fn = true,
      mode = "background",
    })
  end,
}
