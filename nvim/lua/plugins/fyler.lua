local present, fyler = pcall(require, 'fyler')

if not present then return end

fyler.setup {
  integrations = {
    -- icon = "nvim_web_devicons"
  },
  views = {
    finder = {
      close_on_select = true,
      confirm_simple = false,
      default_explorer = true,
      delete_to_trash = true,
      icon = {
        directory_collapsed = nil,
        directory_empty = nil,
        directory_expanded = nil,
      },
      indentscope = { enabled = false },
      mappings = {
        ["<Esc><Esc>"] = "CloseView",
        ["q"] = "CloseView",
        ["<CR>"] = "Select",
        ["<C-t>"] = "SelectTab",
        ["<C-s>v"] = "SelectVSplit",
        ["<C-s>h"] = "SelectSplit",
        ["-"] = "GotoParent",
        ["."] = "GotoCwd",
        ["="] = "GotoNode",
        ["#"] = "CollapseAll",
        ["<BS>"] = "CollapseNode",
      },
      mappings_opts = {
        nowait = false,
        noremap = true,
        silent = true,
      },
      win = {
        border = vim.o.winborder == "" and "single" or vim.o.winborder,
        buf_opts = {
          filetype = "fyler",
          syntax = "fyler",
          buflisted = false,
          buftype = "acwrite",
          expandtab = true,
          shiftwidth = 2,
        },
        kind = "split_right_most",
        win_opts = {
          concealcursor = "nvic",
          conceallevel = 3,
          cursorline = false,
          number = false,
          relativenumber = true,
          winhighlight = "Normal:FylerNormal,NormalNC:FylerNormalNC",
          wrap = false,
          signcolumn = "no",
        },
      },
    },
  },
}
