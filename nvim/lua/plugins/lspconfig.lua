local present, mason = pcall(require, 'mason')

if not present then return end

mason.setup()
local registry = require('mason-registry')

local ensure_installed = {
	"lua-language-server",
	"typescript-language-server",
	"vim-language-server",
	"json-lsp",
	"jdtls",
}

registry.refresh(function()
	for _, tool in ipairs(ensure_installed) do
		local p = registry.get_package(tool)
		if not p:is_installed() then
			p:install()
		end
	end
end)

vim.lsp.enable {
	"lua_ls",
	"ts_ls",
	"vimls",
	"jsonls",
	"jdtls",
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

vim.keymap.set("n", "<leader>ql", vim.diagnostic.setloclist, { desc = "open local diagnostics"} )
vim.keymap.set("n", "<leader>qq", vim.diagnostic.setqflist, { desc = "open global quickfix diagnostics"})

-- disable semantic highlight
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.server_capabilities.semanticTokensProvider then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
