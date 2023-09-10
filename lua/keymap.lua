local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- leader+space=telescope
map('', '<leader>t', ':Telescope<CR>')

-- leader+l=format
map('', '<leader>l', ':Format<CR>')

-- leader+shift+g=live-gref
map('', '<leader><S-g>', ':lua require(\'telescope\').extensions.live_grep_args.live_grep_args()<CR>')

-- leader+shift+ff=fuzzy-finder
map('', '<leader><S-f>', ':Telescope find_files<CR>')

-- leader+f=find-in-current-file
map('', '<leader>f', ':SearchBoxIncSearch<CR>')

-- leader+r=recent-files
map('', '<leader>r', ':Telescope oldfiles<CR>')

-- leader+shift+r=replace-in-current-file
map('', '<leader><S-r>', ':SearchBoxReplace<CR>')

-- leader+g=goto-definition
map('', '<leader>g', ':lua vim.lsp.buf.definition()<CR>')

-- leader+k=lspsaga-hover-doc
map('', '<leader>k', ':lua vim.lsp.buf.hover()<CR>')

-- leader+/=comment-using-nvim-comment
map('', '<leader>/', ':CommentToggle<CR>')
