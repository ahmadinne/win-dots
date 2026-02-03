local present, blink = pcall(require, 'blink.cmp')

if not present then return end

blink.setup {
	signature = {
		enabled = true,
		window = { show_documentation = true },
	},

	completion = {
		accept = {
			auto_brackets = { enabled = false },
		},
		menu = {
			auto_show = true,
			auto_show_delay_ms = 0,
			draw = {
				columns = { { "label", "label_description", gap = 1 }, { "kind" } },
			}
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 1000,
		}
	},

	keymap = {
		["<C-_>"] = { "show" }
	},

	cmdline = { enabled = true },

	sources = {
		-- default = { 'lsp', 'path', 'buffer', 'snippets' },
		default = function()
			local success, node = pcall(vim.treesitter.get_node)
			if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
				return { 'buffer' }
			elseif vim.bo.filetype == 'lua' then
				return { 'lsp', 'path' }
			else
				return { 'lsp', 'path', 'snippets', 'buffer' }
			end
		end,
		providers = {}
	},

	-- opts_extend = { "sources.default" },

}

