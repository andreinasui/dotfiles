return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_restore = true,
      log_level = "error",
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>")
    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>")
  end,
}
