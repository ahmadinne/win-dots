-- ahmadinne's Neovim configuration
-- Dependencies : Neovim, npm or nodejs, and c compiler(gcc, etc)


vim.loader.enable()
vim.g.mapleader = " "
vim.g.do_filetype_lua = 1
vim.opt.termguicolors = true


-- Import from subFolder
local modules = {
	'options',
	'plugins',
	'keymaps'
}

for _, a in ipairs(modules) do
  local ok, err = pcall(require, a)
  if not ok then
    error("Error calling " .. a .. err)
  end
end
