require('lspconfig').rust_analyzer.setup {
	on_attach = require('lsp-format').on_attach,
}
