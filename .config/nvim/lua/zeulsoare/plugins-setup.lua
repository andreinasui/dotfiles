local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Remap space as leader key
-- NOTE: Must set leader keymap before requiring plugins to ensure
-- it is working as expected
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Disable netrw - recommended by NvimTree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup({
	-- lua functions that many plugins use
	"nvim-lua/plenary.nvim",

	-- dashboard (startup page)
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- QOL
	{ "kazhala/close-buffers.nvim" },

	-- Color schemes
	"sainnhe/gruvbox-material",
	"sainnhe/everforest",

	-- Unicode helper
	{ "chrisbra/unicode.vim" },
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	},

	-- tmux & split window navigation
	"christoomey/vim-tmux-navigator",

	-- maximizes and restores current window
	"szw/vim-maximizer",

	-- surround text/code
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- comment code
	{ "numToStr/Comment.nvim", dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" } },

	-- file explorer
	"nvim-tree/nvim-tree.lua",

	-- status line
	"nvim-lualine/lualine.nvim",
	-- buffer line
	"akinsho/bufferline.nvim",

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-rs.nvim",
			"nvim-telescope/telescope-fzf-writer.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			"nvim-telescope/telescope-hop.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
	},

	-- autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"lukas-reineke/cmp-under-comparator",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	},

	-- snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",

	-- LSP
	{ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
	{ "glepnir/lspsaga.nvim", branch = "main" },
	"jose-elias-alvarez/typescript.nvim",
	"onsails/lspkind.nvim",

	-- formatting & linting
	"nvimtools/none-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = false })
			ts_update()
		end,
		dependencies = {
			"windwp/nvim-ts-autotag", -- autoclose tags
			"nvim-treesitter/nvim-treesitter-refactor",
		},
	},
	-- hyprlang treesitter
	{
		"luckasRanarison/tree-sitter-hyprlang",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	-- auto closing
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...

	-- git integration
	{ "tpope/vim-fugitive" }, -- git wrapper in neovim
	{ "lewis6991/gitsigns.nvim" }, -- show line modifications on left hand side

	-- diagnostics
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- css colors in nvim
	"NvChad/nvim-colorizer.lua",
	{ "ziontee113/color-picker.nvim" },

	-- markdown previewer
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- nvim session
	{ "rmagatti/auto-session" },

	-- AI integration
	-- Tabnine https://www.tabnine.com
	{ "codota/tabnine-nvim", build = "./dl_binaries.sh" },

	-- Sonarlint
	{ url = "https://gitlab.com/schrieveslaach/sonarlint.nvim" },
	-- ChatGPT
	-- {
	-- 	"jackMort/ChatGPT.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- },
})
