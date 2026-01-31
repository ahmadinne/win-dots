local ok, indent = pcall(require, 'ibl')

if not ok then
	return
end

indent.setup {
	indent = {
		char = '│',
	},
	scope = {
		show_start = false,
		show_end = false,
	},
}
