require 'lsp.css'
require 'lsp.html'
require 'lsp.rust'
require 'lsp.ts'
require 'lsp.vue'
require 'lsp.lua_ls'
require 'lsp.json'
require 'lsp.tailwind'
require 'lsp.dart'
require 'lsp.go'
require 'lsp.cpp'

vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
vim.api.nvim_create_autocmd('LspAttach', {
	group = 'LspAttach_inlayhints',
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		require('lsp-inlayhints').on_attach(client, bufnr)
		require('lsp-format').on_attach(client, bufnr)
	end,
})
