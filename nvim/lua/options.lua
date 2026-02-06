-- ahmadinne's Options


-- Colorscheme Configurations
vim.o.termguicolors = true
vim.o.background = "dark"


-- Options
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
vim.o.mouse = "a"
vim.opt.fillchars = { eob = " " }
vim.o.cmdheight = 1
vim.o.laststatus = 3


-- Disable builtin vim plugins
local built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "rrhelper",
  "spellfile_plugin",
  "tar",
  "tarPlugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

