return {

  { "tpope/vim-fugitive", event = { "BufReadPre", "BufNewFile" } }, -- git wrapper in neovim

  { "lewis6991/gitsigns.nvim", config = true }, -- show line modifications on left hand side
}
