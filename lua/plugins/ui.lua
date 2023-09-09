local function lualine_config()
	-- Eviline config for lualine
	-- Author: shadmansaleh
	-- Credit: glepnir
	local lualine = require 'lualine'

	-- Color table for highlights
	-- stylua: ignore
	local colors = {
		bg       = '#202328',
		fg       = '#bbc2cf',
		yellow   = '#ECBE7B',
		cyan     = '#008080',
		darkblue = '#081633',
		green    = '#98be65',
		orange   = '#FF8800',
		violet   = '#a9a1e1',
		magenta  = '#c678dd',
		blue     = '#51afef',
		red      = '#ec5f67',
	}

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand '%:t') ~= 1
		end,
		hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand '%:p:h'
			local gitdir = vim.fn.finddir('.git', filepath .. ';')
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	-- Config
	local config = {
		options = {
			-- Disable sections and component separators
			component_separators = '',
			section_separators = '',
			theme = {
				-- We are going to use lualine_c an lualine_x as left and
				-- right section. Both are highlighted by c theme .  So we
				-- are just setting default looks o statusline
				normal = { c = { fg = colors.fg, bg = colors.bg } },
				inactive = { c = { fg = colors.fg, bg = colors.bg } },
			},
		},
		sections = {
			-- these are to remove the defaults
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			-- These will be filled later
			lualine_c = {},
			lualine_x = {},
		},
		inactive_sections = {
			-- these are to remove the defaults
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			lualine_c = {},
			lualine_x = {},
		},
		extensions = {
			'neo-tree',
			'trouble',
		},
	}

	-- Inserts a component in lualine_c at left section
	local function ins_left(component)
		table.insert(config.sections.lualine_c, component)
	end

	-- Inserts a component in lualine_x at right section
	local function ins_right(component)
		table.insert(config.sections.lualine_x, component)
	end

	ins_left {
		function()
			return '▊'
		end,
		color = { fg = colors.blue }, -- Sets highlighting of component
		padding = { left = 0, right = 1 }, -- We don't need space before this
	}

	ins_left {
		-- mode component
		function()
			return ''
		end,
		color = function()
			-- auto change color according to neovims mode
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[''] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[''] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				['r?'] = colors.cyan,
				['!'] = colors.red,
				t = colors.red,
			}
			return { fg = mode_color[vim.fn.mode()] }
		end,
		padding = { right = 1 },
	}

	ins_left {
		-- filesize component
		'filesize',
		cond = conditions.buffer_not_empty,
	}

	ins_left {
		'filename',
		cond = conditions.buffer_not_empty,
		color = { fg = colors.magenta, gui = 'bold' },
	}

	ins_left { 'location' }

	ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

	ins_left {
		'diagnostics',
		sources = { 'nvim_diagnostic' },
		symbols = { error = ' ', warn = ' ', info = ' ' },
		diagnostics_color = {
			color_error = { fg = colors.red },
			color_warn = { fg = colors.yellow },
			color_info = { fg = colors.cyan },
		},
	}

	-- Insert mid section. You can make any number of sections in neovim :)
	-- for lualine it's any number greater then 2
	ins_left {
		function()
			return '%='
		end,
	}

	ins_left {
		-- Lsp server name .
		function()
			local msg = 'No Active Lsp'
			local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
			local clients = vim.lsp.get_active_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end,
		icon = ' LSP:',
		color = { fg = '#ffffff', gui = 'bold' },
	}

	-- Add components to right sections
	ins_right {
		'o:encoding', -- option component same as &encoding in viml
		fmt = string.upper, -- I'm not sure why it's upper case either ;)
		cond = conditions.hide_in_width,
		color = { fg = colors.green, gui = 'bold' },
	}

	ins_right {
		'fileformat',
		fmt = string.upper,
		icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
		color = { fg = colors.green, gui = 'bold' },
	}

	ins_right {
		'branch',
		icon = '',
		color = { fg = colors.violet, gui = 'bold' },
	}

	ins_right {
		'diff',
		-- Is it me or the symbol for modified us really weird
		symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.orange },
			removed = { fg = colors.red },
		},
		cond = conditions.hide_in_width,
	}

	ins_right {
		function()
			return '▊'
		end,
		color = { fg = colors.blue },
		padding = { left = 1 },
	}

	-- Now don't forget to initialize lualine
	lualine.setup(config)
end

return {
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		opts = function(_, opts)
			local function setOpts()
				if opts.routes == nil then
					opts.routes = {}
					return
				end
			end
			setOpts()
			-- opts = getOpts(opts)
			-- opts = opts or { routes = {} }
			table.insert(opts.routes, {
				filter = {
					event = 'notify',
					find = 'No information available',
				},
				opts = { skip = true },
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			'MunifTanjim/nui.nvim',
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			'rcarriga/nvim-notify',
		},
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require('neo-tree').setup {
				filesystem = {
					use_libuv_file_watcher = true,
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
					},
				},
			}
			vim.cmd 'Neotree'
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = lualine_config,
	},
	{
		'stevearc/dressing.nvim',
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'BurntSushi/ripgrep',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				run = 'make',
			},
			{
				'nvim-telescope/telescope-live-grep-args.nvim',
				version = '^1.0.0',
			},
		},
		config = function()
			require('telescope').load_extension 'fzf'
			require('telescope').load_extension 'live_grep_args'
		end,
	},
	{
		'yamatsum/nvim-cursorline',
		config = function()
			require('nvim-cursorline').setup {
				cursorline = {
					enable = true,
					timeout = 1000,
					number = false,
				},
				cursorword = {
					enable = true,
					min_length = 3,
					hl = { underline = true },
				},
			}
		end,
	},
	{
		'dstein64/nvim-scrollview',
		config = function()
			require('scrollview').setup {}
		end,
	},
	-- Breadcrumbs
	{
		'fgheng/winbar.nvim',
		config = function()
			require('winbar').setup {
				enabled = true,

				show_file_path = true,
				show_symbols = true,

				colors = {
					path = '', -- You can customize colors like #c946fd
					file_name = '',
					symbols = '',
				},

				icons = {
					file_icon_default = '',
					seperator = '>',
					editor_state = '●',
					lock_icon = '',
				},

				exclude_filetype = {
					'help',
					'startify',
					'dashboard',
					'packer',
					'neogitstatus',
					'Trouble',
					'alpha',
					'lir',
					'Outline',
					'spectre_panel',
					'toggleterm',
					'qf',
					'neo-tree',
				},
			}
		end,
	},
	-- Indent guide
	{
		'lukas-reineke/indent-blankline.nvim',
	},
	-- dashboard
	{
		'goolord/alpha-nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('alpha').setup(require('alpha.themes.dashboard').config)
		end,
	},
	{
		'folke/trouble.nvim',
	},
	{
		'folke/todo-comments.nvim',
		event = 'BufRead',
		dependencies = { 'nvim-lua/plenary.nvim', 'folke/trouble.nvim' },
		config = function()
			require('todo-comments').setup {}
		end,
	},
	{
		'rebelot/terminal.nvim',
		config = function()
			require('terminal').setup {}
		end,
	},
	{
		'VonHeikemen/searchbox.nvim',
		dependencies = {
			'MunifTanjim/nui.nvim',
		},
	},
	{
		'jubnzv/virtual-types.nvim',
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					offsets = {
						{
							filetype = "neo-tree",
							text = "󰈔 File",
							highlight = "Directory",
						},
					},
				},
			})
		end,
	},
}
