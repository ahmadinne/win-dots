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
	{ import = "plugins.blink" },
	{ "ahmadinne/paradise.nvim" },
	{ "saghen/blink.indent" },
	{ "RRethy/nvim-base16" },
	{ "A7Lavinraj/fyler.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "nvim-mini/mini.surround" },
	{ "nvim-lualine/lualine.nvim" },
	{ "DaikyXendo/nvim-material-icon" }, -- icons
	{ "mason-org/mason-lspconfig.nvim" },
	{ "mason-org/mason.nvim", lazy = false },
	{ "neovim/nvim-lspconfig", lazy = false },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "lewis6991/gitsigns.nvim", event = 'VeryLazy' },
	{
		"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", main = "nvim-treesitter.configs",
		config = function() require('plugins.treesitter') end
	},
}, {
	change_detection = { notify = false },
	checker = { enabled = true, frequency = 604800 }
})


-- Plugins Callout
require "blink.indent".setup()
require "mini.surround".setup()
require "nvim-autopairs".setup()
require "plugins.fyler"
require "plugins.lsp"
require "plugins.blink"
require "plugins.floaterm"
require "plugins.telescope"
require "plugins.mini-move"
require "plugins.treesitter"
require "plugins.lualine"
vim.cmd('colorscheme paradise')
