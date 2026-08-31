return {
  -- lua functions that many plugins use
  "nvim-lua/plenary.nvim",
  -- tmux & split window navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      dofile(vim.fn.expand("~/apps/herdr-local-plugins/vim-herdr-navigation/editor/nvim.lua"))
    end,
  },
  -- maximizes and restores current window
  "szw/vim-maximizer",
  -- QOL
  "kazhala/close-buffers.nvim",
}
