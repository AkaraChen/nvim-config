-- Use UTF-8
vim.g.encoding = "UTF-8"
vim.g.fileencoding = "utf-8"

-- Retain 8 lines above and below the cursor when moving
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Row number
vim.wo.number = true

-- Highlight current line
vim.wo.cursorline = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Watch file change by external editor
vim.o.autoread = true
vim.bo.autoread = true

-- Command bar height
vim.o.cmdheight = 2

-- No wrap
vim.o.wrap = false
vim.wo.wrap = false

-- Allow Jump to next line when in end of line
vim.o.whichwrap = "b,s,<,>,[,],h,l"
