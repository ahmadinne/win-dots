local view, telescope = pcall(require, 'telescope')

if not view then
	return
end

telescope.setup {
  defaults = {
		initial_mode = "insert",
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.60,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
			i = {
				["<esc>"] = require('telescope.actions').close,
				["<C-j>"] = require('telescope.actions').move_selection_next,
				["<C-k>"] = require('telescope.actions').move_selection_previous
			},
    },
		file_ignore_patterns = {
			".git/*",
			".cache/*",
			"node-modules/*"
		}
  },

  extensions_list = { "themes", "terms" },
  extensions = {},
}
