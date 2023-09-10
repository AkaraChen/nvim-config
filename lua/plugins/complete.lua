return {
	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup {}
		end,
	},
	{
		'onsails/lspkind.nvim',
	},
	{
		'neovim/nvim-lspconfig',
	},
	{
		'hrsh7th/nvim-cmp',
		event = { 'InsertEnter', 'CmdlineEnter' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'hrsh7th/cmp-path' },
		},
		config = function()
			-- Setup auto complete
			local status, cmp = pcall(require, 'cmp')
			if not status then
				return
			end
			local lspkind = require 'lspkind'

			cmp.setup {
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert {
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.close(),
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
				},
				sources = cmp.config.sources {
					{ name = 'nvim_lsp' },
					{ name = 'buffer' },
					{ name = 'path' },
				},
				formatting = {
					format = lspkind.cmp_format { with_text = false, maxwidth = 50 },
				},
			}

			vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]
		end,
	},
	{
		'github/copilot.vim',
	},
	{
		'L3MON4D3/LuaSnip',
	},
	-- Git
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end,
	},
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
			local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
			local cmp = require 'cmp'
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end,
	},
	{
		'b0o/SchemaStore.nvim',
	},
	{
		'lukas-reineke/lsp-format.nvim',
		config = function()
			require('lsp-format').setup {}
		end,
	},
	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require('lspsaga').setup {}
		end,
	},
	{
		'lvimuser/lsp-inlayhints.nvim',
		config = function()
			require('lsp-inlayhints').setup {}
		end,
	},
}
