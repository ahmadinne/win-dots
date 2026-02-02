local lualine = require("lualine")

-- Tokyonight Moon colors
local colors = require("paradise.palette")

-- Conditions
local conditions = {
  buffer_not_empty = function()
    return vim.fn.bufname(0) ~= ""
  end,

  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

local config = {
  options = {
    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

local function insert_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function insert_right(component)
  table.insert(config.sections.lualine_x, component)
end

insert_left({
  "mode",
  fmt = function(str)
    -- return str:sub(1, 1) -- N, I, V, R…
		return str
  end,
  color = function()
    local mode = vim.fn.mode()
    local mode_colors = {
      n  = colors.blue,
      i  = colors.green,
      v  = colors.purple,
      V  = colors.purple,
      [""] = colors.purple,
      c  = colors.orange,
      r  = colors.red,
      R  = colors.red,
      t  = colors.red,
    }

    return {
      fg = mode_colors[mode] or colors.fg,
      gui = "bold",
			bg = colors.bg_dark1
    }
  end,
  padding = { left = 1, right = 1 },
})

-- Left
-- insert_left({
--   function()
--     local ok, devicons = pcall(require, "nvim-web-devicons")
--     if not ok then
--       return ""
--     end
--
--     local filename = vim.fn.expand("%:t")
--     local extension = vim.fn.expand("%:e")
--
--     local icon, hl = devicons.get_icon(filename, extension, { default = true })
--
--     if not icon then
--       return ""
--     end
--
--     return string.format("%%#%s#%s%%*", hl, icon)
--   end,
--   padding = { left = 1, right = 0 },
--   cond = conditions.buffer_not_empty,
-- })

insert_left({
	"filename",
	path = 1,
	symbols = {
    modified = " ●",
    readonly = " ",
    unnamed = "[No Name]",
	},
	color = { fg = colors.fg, gui = "bold" },
	cond = conditions.buffer_not_empty,
})

insert_left({
  "branch",
  icon = "",
  color = { fg = colors.fg, gui = "bold" },
})

insert_left({
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})

insert_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
  },
})

-- Right
insert_right({
  "location",
  color = { fg = colors.fg_dark },
  cond = conditions.buffer_not_empty,
})

insert_right("encoding")
insert_right("filetype")

lualine.setup(config)

