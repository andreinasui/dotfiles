-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")

if not status then
	return
end

-- add list of plugins to install
return packer.startup({
	function(use)
		-- packer can manage itself
		use("wbthomason/packer.nvim")

		-- lua functions that many plugins use
		use("nvim-lua/plenary.nvim")

		-- speed up nvim load
		use("lewis6991/impatient.nvim")

		-- dashboard (startup page)
		use({
			"goolord/alpha-nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
		})

		-- Color schemes
		use("sainnhe/gruvbox-material")
		use("sainnhe/everforest")

		-- tmux & split window navigation
		use("christoomey/vim-tmux-navigator")

		-- maximizes and restores current window
		use("szw/vim-maximizer")

		-- surround text/code
		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		})
		use("vim-scripts/ReplaceWithRegister")

		-- comment code
		use({ "numToStr/Comment.nvim", requires = { "JoosepAlviste/nvim-ts-context-commentstring" } })

		-- file explorer
		use("nvim-tree/nvim-tree.lua")

		-- icons
		use("kyazdani42/nvim-web-devicons")

		-- status line
		use("nvim-lualine/lualine.nvim")

		-- telescope
		use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({ "nvim-telescope/telescope-rs.nvim" })
		use({ "nvim-telescope/telescope-fzf-writer.nvim" })
		use({ "nvim-telescope/telescope-packer.nvim" })
		use({ "nvim-telescope/telescope-fzy-native.nvim" })
		use({ "nvim-telescope/telescope-github.nvim" })
		use({ "nvim-telescope/telescope-symbols.nvim" })
		use({ "nvim-telescope/telescope-hop.nvim" })
		use({ "nvim-telescope/telescope-file-browser.nvim" })
		use({ "nvim-telescope/telescope-ui-select.nvim" })

		-- autocompletion
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use("saadparwaiz1/cmp_luasnip")

		-- snippets
		use("L3MON4D3/LuaSnip")
		use("rafamadriz/friendly-snippets")

		-- LSP
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")
		use("neovim/nvim-lspconfig")
		use({ "glepnir/lspsaga.nvim", branch = "main" })
		use("jose-elias-alvarez/typescript.nvim")
		use("onsails/lspkind.nvim")

		-- formatting & linting
		use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
		use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

		-- treesitter configuration
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
				ts_update()
			end,
		})
		use("nvim-treesitter/nvim-treesitter-refactor")

		-- auto closing
		use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
		use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

		-- git integration
		use({ "lewis6991/gitsigns.nvim", tag = "release" }) -- show line modifications on left hand side

		-- diagnostics
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		})

		-- markdown live preview inside nvim
		use({ "ellisonleao/glow.nvim" })

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		profile = {
			enable = true,
			threshold = 1, -- the amount in ms that a plugin's load time must be over for it to be included in the profile
		},
	},
})