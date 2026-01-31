-- Normal Maps
vim.keymap.set("n", "<leader>so", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', '::bp<bar>sp<bar>bn<bar>bd<CR>')

vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<cr>')
vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<cr>')
vim.keymap.set('n', '<C-H>', '<cmd>BufferLineMovePrev<cr>')
vim.keymap.set('n', '<C-L>', '<cmd>BufferLineMoveNext<cr>')

vim.keymap.set({ "n", "o", "x" }, "{", "<cmd>keepj normal!{<cr>")
vim.keymap.set({ "n", "o", "x" }, "}", "<cmd>keepj normal!}<cr>")

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("i", "<C-o>", "<C-x><C-o>")


-- Telescope Maps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', function()
	builtin.buffers {
		previewer = false,
    layout_config = {
			width = 50,
			height = 15
		}
	}
end, { desc = "Buffer list" })
vim.keymap.set('n', '<leader>f', builtin.find_files, {desc = "Find Files"})
vim.keymap.set('n', '<leader>d', builtin.diagnostics, { desc = "Diagnostics" })
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = "Help" })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = "LIve Grep"})
vim.keymap.set('n', '<leader>o', builtin.oldfiles, { desc = "Old files"})
vim.keymap.set('n', '<leader>/', function()
	builtin.live_grep {
		grep_open_files = true,
		prompt_title = 'Live grep Opened Files'
	}
end, { desc = "Live Grep Opened Files"})


-- Neotree Maps
local saved_winId = nil
function toggle_tree()
	local current_win = vim.api.nvim_get_current_win()

	if vim.bo.filetype == "neo-tree" then
		if saved_winId and vim.api.nvim_win_is_valid(saved_winId) then
			vim.api.nvim_set_current_win(saved_winId)
		end
		return
	end

	saved_winId = current_win
	vim.cmd('Neotree focus')
end

vim.keymap.set("n", "<leader>e", "<cmd>:lua toggle_tree()<cr>")
vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle<cr>")


-- Multicursor Maps
local mc = require('multicursor-nvim')
vim.keymap.set('n', '<C-n>', function() mc.lineAddCursor(1) end)
vim.keymap.set('n', '<C-p>', function() mc.lineAddCursor(-1) end)
vim.keymap.set('n', '<leader>n', function() mc.lineSkipCursor(1) end)
vim.keymap.set('n', '<leader>p', function() mc.lineSkipCursor(-1) end)
vim.keymap.set('x', '<C-n>', function() mc.matchAddCursor(1) end)
vim.keymap.set('x', '<C-p>', function() mc.matchAddCursor(-1) end)
vim.keymap.set('x', '<leader>n', function() mc.matchSkipCursor(1) end)
vim.keymap.set('x', '<leader>p', function() mc.matchSkipCursor(-1) end)

-- Clasp
vim.keymap.set({ "n", "i" }, "<c-l>", function()
    if
        vim.fn.mode() == "i"
        and package.loaded["multicursor-nvim"]
        and require("multicursor-nvim").numCursors() > 1
    then
        vim.cmd("stopinsert")
    else
        require("clasp").wrap("next")
    end
end)

-- Add and remove cursors with control + left click.
vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
vim.keymap.set("n", "<c-leftdrag>", mc.handleMouseDrag)
vim.keymap.set("n", "<c-leftrelease>", mc.handleMouseRelease)
vim.keymap.set({"n", "x"}, "<c-q>", mc.toggleCursor) -- Disable and enable cursors.

mc.addKeymapLayer(function(layerSet)
	layerSet({"n", "x"}, "<up>", mc.prevCursor)
	layerSet({"n", "x"}, "<down>", mc.nextCursor)
	layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)
	layerSet("n", "<esc>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		else
			mc.clearCursors()
		end
	end)
end)


-- Yank Highlight
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	desc = "Highlight when yanking (copying) text",
-- 	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
-- 	callback = function()
-- 		vim.hl.on_yank()
-- 	end,
-- })


-- Abbreviation
vim.cmd([[
	cnoreabbrev w! :SudaWrite<CR>
]])
