---@diagnostics disable: missing-fields
--- ahmadinne's Neovim configurations ---


-- General settings
do
	vim.loader.enable()
	vim.opt.termguicolors = true
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	vim.g.have_nerd_font = true
	vim.o.number = true
	vim.o.relativenumber = true
	vim.opt.shiftwidth = 2
	vim.opt.tabstop = 2
	vim.o.mouse = "a"
	vim.o.showmode = false
	vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
	vim.o.breakindent = true
	vim.o.undofile = true
	vim.opt.incsearch = true
	vim.opt.path = "**"
	vim.o.ignorecase = true
	vim.o.smartcase = true
	vim.o.updatetime = 250
	vim.o.timeoutlen = 300
	vim.o.splitright = true
	vim.o.splitbelow = true
	vim.opt.fillchars = { eob = " " }
	vim.o.signcolumn = "yes:1"
	vim.o.inccommand = 'split'
	vim.o.confirm = true
end


-- Autocmd
do
	vim.cmd("command! -nargs=+ Grep execute 'silent grep! <args>' | copen 42")
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function()
			local path = vim.fn.expand("%:p:h")
			if vim.fn.isdirectory(path) == 1 and path:match("^/") then
				vim.api.nvim_set_current_dir(path)
				local f = io.open("/tmp/nvim_last_dir", "w")
				if f then
					f:write(path)
					f:close()
				end
			end
		end,
	})

	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			if ev.data.kind ~= "delete" then
				return
			end

			vim.notify(
				("Removed plugin: %s"):format(ev.data.spec.name),
				vim.log.levels.INFO
			)
		end,
	})

	-- Pack Clean
	local function pack_clean()
		local unused_plugins = {}

		for _, plugin in ipairs(vim.pack.get()) do
			if not plugin.active then
				table.insert(unused_plugins, plugin.spec.name)
			end
		end

		if #unused_plugins == 0 then
			vim.notify(
				"No unused plugins found.",
				vim.log.levels.INFO
			)
			return
		end

		table.sort(unused_plugins)
		local message = "Unused plugins:\n\n"
		for _, name in ipairs(unused_plugins) do
			message = message .. "  • " .. name .. "\n"
		end

		message = message .. "\nRemove these plugins?"

		local choice = vim.fn.confirm(message, "&Remove\n&Cancel", 2)

		if choice ~= 1 then
			vim.notify(
				"Plugin cleanup cancelled.",
				vim.log.levels.WARN
			)
			return
		end

		vim.notify(
			("Removing %d unused plugin%s..."):format(
				#unused_plugins,
				#unused_plugins == 1 and "" or "s"
			),
			vim.log.levels.INFO
		)

		vim.pack.del(unused_plugins)

		---@diagnostic disable-next-line: missing-fields
		vim.notify("Plugin cleanup complete.", vim.log.levels.INFO, {
			title = "vim.pack",
		})
	end
	vim.api.nvim_create_user_command("PackClean", pack_clean, {})
	vim.api.nvim_create_user_command("PackUpdate", function() vim.pack.update() end, {})
end


-- Keymaps
do
	-- Highlight yanking
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	-- Diagnostics
	vim.diagnostic.config({
		update_in_insert = false,
		severity_sort = true,
		float = { border = 'rounded', source = 'if_many' },
		underline = { severity = { min = vim.diagnostic.severity.WARN } },
		virtual_text = true, -- text shows up at the end of the line
		virtual_lines = false, -- text shows up underneath the line, with virtual lines
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.INFO] = " ",
				[vim.diagnostic.severity.HINT] = " ",
			},
		},
		jump = {
			on_jump = function(_, bufnr)
				vim.diagnostic.open_float {
					bufnr = bufnr,
					scope = 'cursor',
					focus = false,
				}
			end,
		}
	})


	-- Za keymappp
	vim.keymap.set("ca", "w!", "SudaWrite")
	vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>")
	vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
	vim.keymap.set("i", "<C-Space>", function(cmp) return cmp.show() end, { desc = 'Show autocompletion' })
	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = 'Focus to the left split' })
	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = 'Focust to the bottom split' })
	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = 'Focus to the top split' })
	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = 'Focus to the right split' })
	vim.keymap.set("n", "<leader><leader>", function() require("buffer_manager.ui").toggle_quick_menu() end, { desc = "Quick menu" })
	vim.keymap.set("n", "<leader>f", ":find ", { desc = "[F]ind" })
	vim.keymap.set("n", "<leader>g", ":Grep ", { desc = "[G]rep" })
	vim.keymap.set("n", "<leader>x", "<CMD>copen<CR>", { desc = "Open quickfi[X]s list" })
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
	vim.keymap.set("n", "<leader>p", "<CMD>bp<CR>", { desc = "Focus previous buffer" })
	vim.keymap.set("n", "<leader>n", "<CMD>bn<CR>", { desc = "Focus next buffer" })
	vim.keymap.set("n", "<leader>e", function() require('fyler').toggle() end, { desc = "Toggle Fyler", })
	vim.keymap.set("n", "<leader>u", "<CMD>Undotree<CR>", { desc = "Open [U]ndotree" })
	vim.keymap.set("n", "<leader>so", function()
		local ft = vim.bo.filetype
		if ft == "lua" then
			vim.cmd("update")
			vim.cmd("source %")
			print("Lua file updated and sourced!")
		else
			vim.cmd("filetype detect")
			local new_ft = vim.bo.filetype
			new_ft = new_ft ~= "" and new_ft or "unknown"
			print(string.format("filetype detected: %s", new_ft))
		end
	end, { desc = '[So]urce the files / Format current file' })
end


-- Plugins
do
	vim.cmd("packadd nvim.undotree")
	vim.pack.add({
		{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range '1.*' },
		"https://github.com/evergardentheme/nvim", -- theme / colorscheme
		"https://github.com/nvim-lua/plenary.nvim", -- buffer_manager deps
		"https://github.com/j-hui/fidget.nvim", -- lsp notifications
		"https://github.com/folke/which-key.nvim",
		"https://github.com/folke/todo-comments.nvim",
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/mason-org/mason.nvim",
		"https://github.com/mason-org/mason-lspconfig.nvim", -- mason deps
		"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- mason deps
		"https://github.com/kylechui/nvim-surround",
		"https://github.com/nvim-mini/mini.comment",
		"https://github.com/nvim-mini/mini.icons",
		"https://github.com/nvim-mini/mini.ai",
		"https://github.com/lambdalisue/vim-suda",
		"https://github.com/brenoprata10/nvim-highlight-colors",
		"https://github.com/brianhuster/live-preview.nvim",
		"https://github.com/pteroctopus/faster.nvim",
		"https://github.com/yuezk/vim-js",
		"https://github.com/HerringtonDarkholme/yats.vim",
		"https://github.com/MaxMEllon/vim-jsx-pretty",
		"https://github.com/j-morano/buffer_manager.nvim",
		"https://github.com/FylerOrg/fyler.nvim",
		"https://github.com/luukvbaal/statuscol.nvim",
	})


	require("paradise")
	require("fidget").setup({})
	require("faster").setup()
	require("nvim-highlight-colors").setup({})
	require("todo-comments").setup { signs = false }
	require("nvim-surround").setup()
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
	require("mini.comment").setup()
	require("buffer_manager").setup()
	require("statuscol").setup({ relculright = true })

	require("mini.ai").setup({
		mappings = {
			around_next = 'aa',
			inside_next = 'ii',
		},
		n_lines = 500,
	})

	require("which-key").setup({
		delay = 600,
		icons = { mappings = vim.g.have_nerd_font },
	})

	-- explorer
	require("fyler").setup({
		use_as_default_explorer = true,
		auto_confirm_simple_mutation = false,
		bound_cursor = true,
		follow_current_file = true,
		kind = 'floating',
		kind_presets = {
			-- floating = { width = '60%', height = '80%' }
			split_left_most = { width = '15%' }
		},
		integrations = {
			icon = 'mini_icons'
		},
		extensions = {},
		ui = {
			hidden_items = {
				always_hidden = { 'node_modules' }
			}
		},
		buf_opts = {
			bufhidden = 'hide',
			buflisted = false,
			buftype = 'acwrite',
			expandtab = true,
			filetype = 'fyler',
			syntax = 'fyler',
			swapfile = false,
		},
		win_opts = {
			number = false,
			relativenumber = false,
			concealcursor = 'nvic',
			conceallevel = 3,
			cursorline = true,
			wrap = false,
			signcolumn = 'no',
		},

		mappings = {
			n = {
				['h'] = { action = 'shrink', args = { parent = false }, desc = 'Collapse parent directory' },
				['l'] = { action = 'expand', args = { parent = false }, desc = 'Open file / directory' },
				['<CR>'] = { action = 'select', args = { pick = true }, desc = 'Open file / directory' },
				['<C-r>'] = { action = 'refresh', args = { recursive = true, force = true }, desc = 'Force refresh tree' },
				['<C-s>'] = { action = 'select', args = { split = true }, desc = 'Open in horizontal split' },
				['<C-v>'] = { action = 'select', args = { vsplit = true }, desc = 'Open in vertical split' },
				['.'] = { action = 'toggle_ui', args = { 'hidden_items' }, desc = 'Toggle hidden files', },
				['q'] = { action = 'close', desc = 'Close fyler' },
				['<Esc>'] = { action = 'close', desc = 'Close fyler' },
			}
		}
	})

end


-- LSPS
do
  local servers = {
		ts_ls = {},
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" }, },
          workspace = { library = vim.api.nvim_get_runtime_file("", true), },
          telemetry = { enable = false, },
        },
      },
    },
  }

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_enable = true,
  })
  require("mason-tool-installer").setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  for name, config in pairs(servers) do
    config.on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }

      vim.keymap.set({ "n", "v" }, "<leader>r", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end

    vim.lsp.config(name, config)
  end
end


-- Autocomplete and Treesitter
do
	-- Autocomplete
	require('blink-cmp').setup({
		appearance = { nerd_font_variant = 'mono' },
		completion = {
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
			menu = { auto_show = false }
		},
		sources = {
			default = { 'lsp', 'path', 'buffer' }
		},
		fuzzy = { implementation = 'lua' },
		signature = { enabled = true },
		keymap = {
			preset = 'default',
			['<C-Space>'] =  { 'show' }
		},
	})

	-- Treesitter
  local parsers = {
    "bash",
    "c",
    "diff",
    "html",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "query",
    "vim",
    "vimdoc",
  }
  require("nvim-treesitter").install(parsers)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "bash",
      "c",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "query",
      "vim",
      "vimdoc",
    },
    callback = function(args)
      local language = vim.treesitter.language.get_lang(args.match)

      if language then
        pcall(vim.treesitter.start, args.buf, language)
      end
    end,
  })
end
