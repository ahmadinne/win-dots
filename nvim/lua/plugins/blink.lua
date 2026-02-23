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
				components = {
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon
							if ctx.item.source_name == "LSP" then
								local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr ~= "" then
									icon = color_item.abbr
								end
							end
							return icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							local highlight = "BlinkCmpKind" .. ctx.kind
							if ctx.item.source_name == "LSP" then
								local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr_hl_group then
									highlight = color_item.abbr_hl_group
								end
							end
							return highlight
						end,
					}
				}
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

