vim.g.mapleader = " "

local keymap = vim.keymap

local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap.set("n", "<ESC>", ":nohlsearch <CR>", opts)

keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Telescope
keymap.set("n", "<leader>ff", ":Telescope find_files <CR>", opts)
keymap.set("n", "<leader>fb", ":Telescope buffers <CR>", opts)
keymap.set("n", "<leader>fc", ":Telescope colorscheme <CR>", opts)
keymap.set("n", "<leader>fb", ":Telescope buffers <CR>", opts)
keymap.set("n", "<leader>gb", ":Telescope git_branches <CR>", opts)

-- NvimTree
keymap.set("n", "<leader>e", ":NvimTreeToggle <CR>", opts)

-- Navagation
keymap.set("n", "<C-h>", "<C-w><C-h>")
keymap.set("n", "<C-l>", "<C-w><C-l>")
keymap.set("n", "<C-k>", "<C-w><C-k>")
keymap.set("n", "<C-j>", "<C-w><C-l>")

-- Lsp
keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, opts)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap.set("n", "gr", vim.lsp.buf.references, opts)
keymap.set("n", "<leader>f", ":Format <CR>", opts)

-- Markdown
keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle <CR>", opts)

-- Obsidian
keymap.set("n", "<leader>on", ":ObsidianTemplate notes<CR>", opts)
keymap.set("n", "<leader>osp", ":! python3 ~/.local/bin/obsidian.py --sync push<CR>", opts)
keymap.set("n", "<leader>osP", ":! python3 ~/.local/bin/obsidian.py --sync pull<CR>", opts)
