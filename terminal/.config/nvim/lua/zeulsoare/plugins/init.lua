return {
  -- lua functions that many plugins use
  "nvim-lua/plenary.nvim",
  -- tmux & split window navigation
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- maximizes and restores current window
  "szw/vim-maximizer",
  -- QOL
  "kazhala/close-buffers.nvim",
  -- surround text/code
  -- {
  -- 	"kylechui/nvim-surround",
  -- 	version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --  }
}
