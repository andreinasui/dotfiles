local function toggle_telescope(harpoon_files)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  local file_paths = {}
  for _, file in ipairs(harpoon_files.items) do
    table.insert(file_paths, file.value)
  end
  pickers
    .new({}, {
      prompt_title = "Harpoon Files",
      finder = finders.new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

return {

  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  keys = {
    {
      "<leader>hh",
      function()
        toggle_telescope(require("harpoon"):list())
      end,
      desc = "Open harpoon window",
    },
    {
      "<leader>ha",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon file",
    },
    {
      "<leader>hn",
      function()
        require("harpoon"):list():next()
      end,
      desc = "Next harpooned file",
    },
    {
      "<leader>hp",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "Previous harpooned file",
    },
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})
    -- vim.keymap.set("n", "<leader>hh", function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = "Open harpoon window" })
  end,
}
