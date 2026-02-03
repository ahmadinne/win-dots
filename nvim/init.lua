-- ahmadinne's Neovim configuration
-- Dependencies : Neovim, npm or nodejs, and c compiler(gcc, etc)


vim.loader.enable()
vim.g.mapleader = " "
vim.g.do_filetype_lua = 1
vim.opt.termguicolors = true


-- Import from subFolder
local modules = {
	'options',
	'lazy-pm',
	'keymaps'
}


for _, a in ipairs(modules) do
  local ok, err = pcall(require, a)
  if not ok then
    error("Error calling " .. a .. err)
  end
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
