local present, blink = pcall(require, 'blink.cmp')

if not present then return end

blink.setup {
  completion = {
    accept = {
      auto_brackets = { enabled = false },
    },
    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          }
        }
      }
    },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 1000,
    }
  },

  keymap = {
    preset = 'default',
    ["<C-space>"] = { function(cmp) cmp.show({}) end },
  },

  cmdline = { enabled = true },

  sources = {
    default = { 'lsp', 'path', 'buffer', 'snippets' },
    -- default = function()
    --   local success, node = pcall(vim.treesitter.get_node)
    --   if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
    --     return { 'buffer' }
    --   elseif vim.bo.filetype == 'lua' then
    --     return { 'lsp', 'path' }
    --   else
    --     return { 'lsp', 'path', 'snippets', 'buffer' }
    --   end
    -- end,
    providers = {}
  }
}
