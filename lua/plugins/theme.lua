return {
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
			vim.cmd 'colorscheme catppuccin'
		end,
		priority = 1000,
	},
}
