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
	{ "ahmadinne/paradise.nvim" },
	{ "oskarnurm/koda.nvim" },
	{ "romgrk/barbar.nvim" },
	{ "saghen/blink.indent" },
	{ "A7Lavinraj/fyler.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "nvim-mini/mini.surround" },
	{ "nvim-lualine/lualine.nvim" },
	{ "DaikyXendo/nvim-material-icon" }, -- icons
	{ "mason-org/mason.nvim", lazy = false },
	{ "neovim/nvim-lspconfig", lazy = false },
	{ "lewis6991/gitsigns.nvim", event = 'VeryLazy' },
	{ "saghen/blink.cmp", version = "1.*", lazy = false },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", main = "nvim-treesitter.configs" },
}, {
	change_detection = { notify = false },
	checker = { enabled = true, frequency = 604800 } -- 1 Week
})


-- Plugins Callout
require "barbar".setup()
require "mini.surround".setup()
require "nvim-autopairs".setup()
require "plugins.blink-indent"
require "plugins.lspconfig"
require "plugins.fyler"
require "plugins.blink"
require "plugins.telescope"
require "plugins.mini-move"
require "plugins.treesitter"
require "plugins.lualine"
require "modules.floaterm"
require "modules.smart-close"
vim.cmd('colorscheme paradise')
