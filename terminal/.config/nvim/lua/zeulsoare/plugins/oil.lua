-- file detail flag
local detail = false

return {
  "stevearc/oil.nvim",
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
    },
    watch_for_changes = true,
    keymaps = {
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = false,
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-l>"] = false,
      ["<C-r>"] = "actions.refresh",
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
    },
  },
  -- Optional dependencies
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
  },
}
