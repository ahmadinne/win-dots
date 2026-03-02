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
  -- Utils
  { "Wansmer/treesj" },
  { "nvim-mini/mini.icons" },
  { "windwp/nvim-autopairs" },
  { "nvim-mini/mini.surround" },
  { "vague-theme/vague.nvim" },
  { "oskarnurm/koda.nvim" },
  { "A7Lavinraj/fyler.nvim", lazy = false },
  { "lewis6991/gitsigns.nvim", event = 'VeryLazy' },

  -- Lsp
  { "saghen/blink.cmp", version = '1.*' },
  { "mason-org/mason.nvim", lazy = false },
  { "neovim/nvim-lspconfig", lazy = false },
  { "mason-org/mason-lspconfig.nvim", lazy = false },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", main = "nvim-treesitter.configs" },

  -- tyescript typeshi-
  { 'HerringtonDarkholme/yats.vim' },
  { 'yuezk/vim-js' },
  { 'maxmellon/vim-jsx-pretty' }
}, {
  change_detection = { notify = false },
  checker = { enabled = true, frequency = 604800 } -- 1 Week
})

-- Plugins Callout
vim.cmd("colorscheme koda")
require "treesj".setup({})
require "mini.surround".setup()
require "mini.icons".setup()
require "nvim-autopairs".setup()
require "plugins.lspconfig"
require "plugins.blink"
require "plugins.fyler"
require "plugins.treesitter"
require "modules.floaterm"
