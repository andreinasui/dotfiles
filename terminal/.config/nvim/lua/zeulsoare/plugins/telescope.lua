local function normalize_path(path)
  return path:gsub("\\", "/")
end

local function normalize_cwd()
  return normalize_path(vim.loop.cwd()) .. "/"
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match("[^/]+$")

  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    local stripped_path = normalized_path:sub(1, -(#filename + 1))
    return stripped_path, filename
  end
end

local function path_display(_, path)
  local stripped_path, filename = split_filepath(path)
  if filename == stripped_path or stripped_path == "" then
    return filename
  end
  return string.format("%s ~ %s", filename, stripped_path)
end
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "echasnovski/mini.icons", opts = {} },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-rs.nvim",
    "nvim-telescope/telescope-fzf-writer.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-hop.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "alduraibi/telescope-glyph.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local tele_actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")
    -- local trouble = require("trouble.providers.telescope")

    telescope.setup({
      defaults = {
        path_display = path_display,
        mappings = {
          i = {
            ["<C-p>"] = tele_actions.move_selection_previous,
            ["<C-n>"] = tele_actions.move_selection_next,
            ["<C-q>"] = tele_actions.send_selected_to_qflist + tele_actions.open_qflist,
          },
        },
        set_env = { COLORTERM = "truecolor" },
        file_ignore_patterns = { ".git/" },
      },
      pickers = {
        diagnostics = {
          theme = "dropdown",
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ["<C-q>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane}
        },
        glyph = {
          action = function(glyph)
            -- argument glyph is a table.
            -- {name="", value="", category="", description=""}

            vim.fn.setreg("*", glyph.value)
            print([[Press p or "*p to paste this glyph]] .. glyph.value)

            -- insert glyph when picked
            vim.api.nvim_put({ glyph.value }, "c", false, true)
          end,
        },
      },
    })
    telescope.load_extension("live_grep_args")
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("glyph")
    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>")
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>")
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep_args<CR>")
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
    keymap.set("n", "<leader>fx", "<cmd>Telescope diagnostics<CR>")
    keymap.set("n", "<leader>fp", "<cmd>Telescope project project<CR>")
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>")
  end,
}
