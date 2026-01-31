-- ahmadinne's plugin list


-- Bootstrap lazy.nvim
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

-- Plugins List
require("lazy").setup({
	{ "folke/noice.nvim" },
	{ "RRethy/nvim-base16" }, -- paradise.nvim dependencies
	{ "nvim-mini/mini.diff" },
	{ "nvim-mini/mini.move" },
	{ import = 'completion' },
	{ "lambdalisue/vim-suda" },
	{ "MunifTanjim/nui.nvim" }, -- neo-tree.nvim dependencies
	{ "windwp/nvim-autopairs" },
	{ "nvim-lua/plenary.nvim" }, -- telescope.nvim dependencies
	{ "akinsho/bufferline.nvim"},
	{ "nvim-mini/mini.surround" },
	{ "Darazaki/indent-o-matic" },
	{ "ahmadinne/paradise.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-neo-tree/neo-tree.nvim" },
	{ "rachartier/tiny-glimmer.nvim" },
	{ "DaikyXendo/nvim-material-icon" },
	{ "nvim-telescope/telescope.nvim" },
	{ "jake-stewart/multicursor.nvim" },
	{ "mason-org/mason.nvim", lazy = false },
	{ "neovim/nvim-lspconfig", lazy = false },
	{ "lukas-reineke/indent-blankline.nvim" },
  { "lewis6991/gitsigns.nvim", event = 'VeryLazy' },
	{
		"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", main = "nvim-treesitter.configs",
		config = function() require('plugins.treesitter') end
	},
	{
		"folke/lazydev.nvim", ft = "lua", opts = {
			library = {{ path = "${3rd}/luv/library", words = { "vim%.uv" } }}
		}
	}
}, {
	install = { colorscheme = { 'paradise' } },
	change_detection = { notify = false },
	checker = { enabled = true, frequency = 604800 }
})

-- Plugin's Callout
require "tiny-glimmer".setup()
require "nvim-autopairs".setup()
require "multicursor-nvim".setup()
require "mini.surround".setup()
require "bufferline".setup()
require "mini.diff".setup()
require "mason".setup()
require "plugins.indent-blankline"
require "plugins.indent-o-matic"
require('plugins.mini-move')
require('plugins.bufferline')
require('plugins.neo-tree')
require('plugins.telescope')
require('plugins.lualine')
require('plugins.multicursor')
require('plugins.noice')
require('lsp')
require('completion.blink')
