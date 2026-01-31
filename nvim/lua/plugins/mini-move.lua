local ok move = pcall(require, 'mini.move')

if not ok then
	return
end

move.setup {
	mappings = {
		-- Visual mode
		left = '<M-h>',
		right = '<M-l>',
		down = '<M-j>',
		up = '<M-k>',

		-- Normal mode
		line_left = '<M-h>',
		line_right = '<M-l>',
		line_down = '<M-j>',
		line_up = '<M-k>',
	},

	options = {
		reindent_linewise = true,
	}
}
