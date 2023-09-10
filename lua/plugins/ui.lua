local exclude_filetype = {
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
}

local logo = [[

      ___           ___           ___     
     /\  \         /\__\         /\  \    
    /::\  \       /:/  /        /::\  \   
   /:/\:\  \     /:/__/        /:/\:\  \  
  /::\~\:\  \   /::\__\____   /::\~\:\  \ 
 /:/\:\ \:\__\ /:/\:::::\__\ /:/\:\ \:\__\
 \/__\:\/:/  / \/_|:|~~|~    \/_|::\/:/  /
      \::/  /     |:|  |        |:|::/  / 
      /:/  /      |:|  |        |:|\/__/  
     /:/  /       |:|  |        |:|  |    
     \/__/         \|__|         \|__|    

]]

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
		config = function()
			require('lualine').setup {
				options = {
					globalstatus = true,
					component_separators = {},
					section_separators = {},
				},
				extensions = {
					'neo-tree',
					'lazy',
					'trouble',
				},
			}
		end,
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

				exclude_filetype = exclude_filetype,
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
			local dashboard = require 'alpha.themes.dashboard'
			dashboard.section.header.val = vim.split(logo, '\n')
			dashboard.section.buttons.val = {
				dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
				dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
				dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
				dashboard.button('l', '󰒲 ' .. ' Lazy', ':Lazy<CR>'),
				dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
			}
			vim.api.nvim_create_autocmd("User", {
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100) / 100
					dashboard.section.footer.val = "󱐌 Lazy-loaded " .. stats.loaded .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})

			require('alpha').setup(dashboard.config)
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
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
			require('barbar').setup {
				sidebar_filetypes = {
					['neo-tree'] = { event = 'BufWipeout', text = '󰈔 File' },
				},
				animation = false,
				exclude_ft = exclude_filetype,
			}
		end,
	},
}
