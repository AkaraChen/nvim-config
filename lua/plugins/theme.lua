return {
	{
		'zaldih/themery.nvim',
		config = function()
			local config_path = '~/.config/nvim/lua/config/theme.lua'
			require('themery').setup {
				themes = {
					'onedark',
					'catppuccin-latte',
					'catppuccin-frappe',
					'catppuccin-macchiato',
					'catppuccin-mocha',
				},
				themeConfigFile = config_path,
				livePreview = true,
			}
			-- if config_path is exist, require it:
			if vim.fn.filereadable(vim.fn.expand(config_path)) == 1 then
				require 'config.theme'
			else
				vim.cmd 'colorscheme catppuccin-frappe'
			end
		end,
	},
	{
		'olimorris/onedarkpro.nvim',
		priority = 1000,
		config = function()
			-- vim.cmd 'colorscheme onedark'
		end,
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			-- vim.cmd 'colorscheme catppuccin-latte'
		end,
		priority = 1000,
	},
}
