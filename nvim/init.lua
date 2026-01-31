-- ahmadinne's Neovim configuration
-- Dependencies : Neovim, npm or nodejs


-- Install Plugins using Lazy
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
vim.g.mapleader = " "

require("lazy").setup({
	{ "RRethy/base16-nvim" }, -- paradise.nvim dependencies
	{ "nvim-mini/mini.diff" },
	{ "lambdalisue/vim-suda" },
	{ "mason-org/mason.nvim" },
	{ "MunifTanjim/nui.nvim" }, -- neo-tree.nvim dependencies
	{ "windwp/nvim-autopairs" },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-lua/plenary.nvim" }, -- telescope.nvim dependencies
	{ "akinsho/bufferline.nvim"},
	{ "ahmadinne/paradise.nvim" },
	{ "nvim-mini/mini.surround" },
	{ "DaikyXendo/nvim-material-icon" },
	{ "nvim-neo-tree/neo-tree.nvim", config = function() require('plugins.neo-tree') end },
	{ "nvim-telescope/telescope.nvim", config = function() require('plugins.telescope') end },
	{ "jake-stewart/multicursor.nvim", config = function() require('plugins.multicursor') end },
	{
		"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", main = "nvim-treesitter.configs",
		config = function() require('plugins.treesitter') end
	},
	{
		"folke/lazydev.nvim", ft = "lua", opts = {
			library = {{ path = "${3rd}/luv/library", words = { "vim%.uv" } }}
		}
	}
})


-- Plugin's Callout
require "nvim-autopairs".setup()
require "multicursor-nvim".setup()
require "mini.surround".setup()
require "bufferline".setup()
require "mini.diff".setup()
require "mason".setup()


-- Import from subFolder
local modules = {
	'options',
	'keymaps',
	-- 'statusline'
}

for _, a in ipairs(modules) do
  local ok, err = pcall(require, a)
  if not ok then
    error("Error calling " .. a .. err)
  end
end

local ok, statusline = pcall(require, 'statusline')
if not ok then
	error("Error calling " .. statusline)
end


-- Lsps and AutoComplete
vim.lsp.enable({ "lua_ls", "jdtls", "ts_ls", "vimls" })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

