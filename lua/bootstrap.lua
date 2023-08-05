-- Open File Explorer
vim.cmd("Neotree")

-- Status Bar
require("plugin-config.status")

-- Color Schema
vim.cmd("colorscheme onedark")

-- LSP installer
require("mason").setup()

-- Auto complete
require("plugin-config.cmp")

-- Setup LSP
require("lsp.main")

require("bufferline").setup({})
