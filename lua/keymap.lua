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

-- leader+f=format
map('', '<leader>f', ':Format<CR>')

-- leader+g=live-gref
map('', '<leader>g', ':lua require(\'telescope\').extensions.live_grep_args.live_grep_args()<CR>')

-- leader+f=fuzzy-finder
map('', '<leader>f', ':Telescope find_files<CR>')
