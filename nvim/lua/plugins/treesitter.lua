local present, treesitter = pcall(require, 'nvim-treesitter.configs')

if not present then
  return
end

treesitter.setup {
  ensure_installed = {
    "c",
    "bash",
    "diff",
    "query",
    "html",
    "markdown",
    "markdown_inline",
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
  },
  modules = {},
  sync_install = true,
  ignore_install = {},
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true }
}
