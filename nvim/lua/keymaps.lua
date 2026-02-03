-- Abbreviation
vim.keymap.set('c', 'w!', '<cmd>SudaWrite<cr>')


-- Normal Maps
vim.keymap.set('n', '<leader><space>', '<cmd>BufferPick<cr>')
vim.keymap.set('n', '<leader>bd', '<cmd>BufferPickDelete<cr>')
vim.keymap.set("n", "<leader>so", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set('n', '<leader>w', '<CMD>write<CR>')

vim.keymap.set('n', '<C-j>', 'J') -- remap J to Control-J
vim.keymap.set('n', 'H', '<cmd>BufferPrevious<cr>')
vim.keymap.set('n', 'L', '<cmd>BufferNext<cr>')
vim.keymap.set('n', '<leader>H', '<cmd>BufferMovePrevious<cr>')
vim.keymap.set('n', '<leader>L', '<cmd>BufferMoveNext<cr>')

vim.keymap.set({ "n", "o", "x" }, "{", "<cmd>keepj normal!{<cr>")
vim.keymap.set({ "n", "o", "x" }, "}", "<cmd>keepj normal!}<cr>")

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("i", "<C-o>", "<C-x><C-o>")


-- Fyler
local last_win = nil
local fyler = require('fyler')
local function find_fyler_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "fyler" then
			return win
		end
	end
	return nil
end

local function toggle_tree()
	local current_win = vim.api.nvim_get_current_win()

	if vim.bo.filetype == "fyler" then
		if last_win and vim.api.nvim_win_is_valid(last_win) then
			vim.api.nvim_win_close(current_win, true)
			vim.api.nvim_set_current_win(last_win)
		end
		return
	end

	local fyler_win = find_fyler_win()
	if fyler_win then
		fyler.focus()
	else
		last_win = current_win
		fyler.open({ kind = "split_left_most" })
	end
end

vim.keymap.set("n", "<leader>e", function() toggle_tree() end)


-- Yank Highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

