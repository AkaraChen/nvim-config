require('lspconfig').tsserver.setup {
	on_attach = require('lsp-format').on_attach
}
