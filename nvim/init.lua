-- ahmadinne's Neovim configuration
-- Dependencies : Neovim, npm or nodejs


vim.loader.enable()
vim.g.do_filetype_lua = 1
vim.g.mapleader = " "


-- Import from subFolder
local modules = {
	'plugins',
	'options',
	'keymaps',
	'lsp',
}

for _, a in ipairs(modules) do
  local ok, err = pcall(require, a)
  if not ok then
    error("Error calling " .. a .. err)
  end
end


-- Auto commands
vim.api.nvim_create_autocmd({"TermOpen", "TermEnter"}, {
  pattern = "term://*",
  command = "setlocal nonumber norelativenumber signcolumn=no | setfiletype term",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  command = "startinsert"
})

vim.api.nvim_create_autocmd("VimLeave", {
  command = "set guicursor=a:ver20",
})
