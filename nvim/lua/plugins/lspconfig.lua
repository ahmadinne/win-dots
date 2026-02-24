local present, mason = pcall(require, 'mason')

if not present then return end

local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    'lua_ls',
    'cssls',
    'ts_ls',
    'jsonls',
    'vimls',
    'marksman'
  },

  automatic_installation = true,
})

vim.lsp.config("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" }, }, }, }, })
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

function BlinkLsp(_, opts)
  for server, config in pairs(opts.servers) do
    config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
    lspconfig[server].setup(config)
  end
end

function LspCall()
  local capabilities = require('blink.cmp').get_lsp_capabilities()
  lspconfig['lua_ls'].setup({ capabilities = capabilities })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

capabilities = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
  }
})
