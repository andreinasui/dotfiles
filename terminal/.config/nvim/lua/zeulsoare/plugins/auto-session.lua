return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      log_level = "error",
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>")
    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>")
  end
}
