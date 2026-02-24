-- ahmadinne's Neovim configuration
-- Dependencies : Neovim, npm or nodejs, and c compiler(gcc, etc)

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

-- Language Server Protocol (LSP) and Diagnostics
vim.lsp.set_log_level("WARN")

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  severity_sort = true
})
