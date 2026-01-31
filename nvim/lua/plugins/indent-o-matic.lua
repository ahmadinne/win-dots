local ok, iom = pcall(require, 'indent-o-matic')

if not ok then
	return
end

iom.setup {
	max_lines = 2048,
	standard_widths = { 2, 4, 8 },
	skip_multiline = false
}
