local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }

-- Tab
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- UI
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.colorcolumn = "100"
opt.splitright = true
opt.splitbelow = true
-- opt.list = true
-- opt.listchars = { tab = "│ " }
opt.conceallevel = 1

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
