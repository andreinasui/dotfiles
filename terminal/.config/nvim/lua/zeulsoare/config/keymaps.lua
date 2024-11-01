vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local keymap_normal = function(key, mapping, options)
	options = options or opts
	keymap("n", key, mapping, options)
end

local keymap_insert = function(key, mapping, options)
	options = options or opts
	keymap("i", key, mapping, opts)
end

local keymap_visual = function(key, mapping, options)
	options = options or opts
	keymap("v", key, mapping, opts)
end

local keymap_visual_block = function(key, mapping, options)
	options = options or opts
	keymap("x", key, mapping, opts)
end

local keymap_term = function(key, mapping, options)
	options = options or opts
	keymap("t", key, mapping, opts)
end

local keymap_command = function(key, mapping, options)
	options = options or opts
	keymap("c", key, mapping, opts)
end

-- Normal mode
--genearal keymaps
keymap_normal("x", '"_x') -- do not copy single char to copy register
keymap_normal("<leader>nh", ":nohl<CR>") -- remove highlight from searched test
keymap_normal("<leader>sv", "<C-w>v") -- split window vertically
keymap_normal("<leader>sh", "<C-w>s") -- split window horizontally
keymap_normal("<leader>se", "<C-w>=") -- make split windows equal width
keymap_normal("<leader>sx", ":close<CR>") -- close current split window
keymap_normal("<leader>sm", ":MaximizerToggle<CR>") -- vim-maximizer
keymap_normal("<leader>to", ":tabnew<CR>") -- open new tab
keymap_normal("<leader>tx", ":tabclose<CR>") -- close current tab
keymap_normal("<leader>tn", ":tabn<CR>") -- go to next tab
keymap_normal("<leader>tp", ":tabp<CR>") -- go to previous tab
keymap_normal("<M-l>", ":tabn<CR>") -- go to next tab
keymap_normal("<M-h>", ":tabp<CR>") -- go to previous tab
keymap_normal("<leader>cc", "<cmd>PickColor<CR>")
-- Remap gx to open links because we unloaded netrw for nvim-tree
keymap_normal("gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>')
-- Move text up and down
keymap_normal("<A-k>", ":m .-2<CR>==")
keymap_normal("<A-j>", ":m .+1<CR>==")
-- Remap increment/decrement
keymap_normal("+", "<C-a>")
keymap_normal("-", "<C-x>")
-- Center view on page up/down movements
keymap_normal("<C-d>", "<C-d>zz")
keymap_normal("<C-u>", "<C-u>zz")
-- keymap_normal("<leader>w", ":w<CR>")
-- keymap_normal("<leader>wa", ":wa<CR>")
-- keymap_normal("<leader>q", ":q<CR>")
-- keymap_normal("<leader>qa", ":qa<CR>")
-- keymap_normal("<leader><leader>s", ":so<CR>")
keymap_normal("<leader>y", '"+y') -- copy to system clipboard
keymap_normal("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true, silent = false })

-- Visual --
-- Stay in indent mode
keymap_visual("<", "<gv")
keymap_visual(">", ">gv")
-- Move text up and down
keymap_visual("<A-k>", ":move '<-2<CR>gv=gv")
keymap_visual("<A-j>", ":move '>+1<CR>gv=gv")
keymap_visual("p", '"_dP')
keymap_visual("<leader>y", '"+y') -- copy to system clipboard

-- Visual Block --
-- Move text up and down
keymap_visual_block("<A-k>", ":move '<-2<CR>gv=gv")
keymap_visual_block("<A-j>", ":move '>+1<CR>gv=gv")
