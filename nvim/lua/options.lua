-- Colorscheme Configurations
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd.colorscheme("paradise")
vim.cmd[[
	highlight NvimTreeStatusLineNC guibg=none guifg=none
]]


-- Options
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.o.autochdir = true
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.opt.fillchars = { eob = " " }


-- Disable builtin vim plugins
local built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
