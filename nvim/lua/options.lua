-- ahmadinne's Options

vim.loader.enable()
vim.g.mapleader = " "
vim.g.do_filetype_lua = 1
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes:1"
vim.o.wrap = false
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.swapfile = false
vim.o.autochdir = true
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.opt.fillchars = { eob = " " }

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

-- Fix error when exiting neovim
vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
  group = vim.api.nvim_create_augroup('fuck_shada_temp', { clear = true }),
  pattern = { '*' },
  callback = function()
    local status = 0
    for _, f in ipairs(vim.fn.globpath(vim.fn.stdpath('data') .. '/shada', '*tmp*', false, true)) do
      if vim.tbl_isempty(vim.fn.readfile(f)) then
	status = status + vim.fn.delete(f)
      end
    end
    if status ~= 0 then
      vim.notify('Could not delete empty temporary ShaDa files.', vim.log.levels.ERROR)
      vim.fn.getchar()
    end
  end,
  desc = "Delete empty temp ShaDa files"
})
