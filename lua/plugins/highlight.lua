return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			require('nvim-treesitter.install').update { with_sync = true }
		end,
	},
	{
		'NvChad/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end,
	},
}
