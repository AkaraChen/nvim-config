local lsp = require 'lspconfig'
lsp.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
		},
	},
	on_attach = require('lsp-format').on_attach,
}
