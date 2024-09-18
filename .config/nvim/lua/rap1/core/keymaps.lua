vim.g.mapleader = " "

local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<ESC>", ":nohlsearch <CR>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files <CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers <CR>", opts)
vim.keymap.set("n", "<leader>fc", ":Telescope colorscheme <CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers <CR>", opts)
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches <CR>", opts)

-- NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle <CR>", opts)

-- Navagation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-j>", "<C-w><C-l>")

-- Lsp
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "<leader>f", ":Format <CR>", opts)

-- Markdown
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle <CR>", opts)

-- Obsidian
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate notes<CR>", opts)
vim.keymap.set("n", "<leader>osp", ":! python3 ~/.local/bin/obsidian.py --sync push<CR>", opts)
vim.keymap.set("n", "<leader>osP", ":! python3 ~/.local/bin/obsidian.py --sync pull<CR>", opts)
