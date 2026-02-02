local ok, neotree = pcall(require, 'neo-tree')

if not ok then
	return
end

neotree.setup {
	close_if_last_window = true,
	popup_border_style = "NC",
	clipboard = { sync = "none" },
	group_empty_dirs = true,
	hijack_netrw_behavior = "current",
	sources = { "filesystem", "buffers", "git_status" },
	open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
	enable_git_status = true,
	enable_diagnostics = true,
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
	window = {
		position = "right",
		width = "31",
		mapping_options = {
			noremap = true,
			nowait = true
		},
		mappings = {
			["-"] = "navigate_up",
			["="] = "set_root",
			["."] = "toggle_hidden",
			["H"] = "none",
			["l"] = { "toggle_node", nowait = true },
			["h"] = "close_node",
			["<space>"] = "none",
			["Y"] = {
				function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.fn.setreg("+", path, "c")
				end,
				desc = "Copy path to clipboard",
			},
			["O"] = {
				function(state)
					require("lazy.util").open(state.tree:get_node().path, { system = true })
				end,
				desc = "Open with system application",
			},
			["P"] = { "toggle_preview", config = { use_float = true } },
		},
	}
}
