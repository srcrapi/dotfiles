local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	window = {
		completion = {
			side_padding = 0,
			border = "rounded",
			scrollbar = "║",
		},
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	mapping = cmp.mapping.preset.insert({
		-- Use <C-b/f> to scroll the docs
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- Use <C-k/j> to switch in items
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- Use <CR>(Enter) to confirm selection
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		-- A super tab
		-- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
		["<Tab>"] = cmp.mapping(function(fallback)
			-- Hint: if the completion menu is visible select next one
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }), -- i - insert mode; s - select mode
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	formatting = {
		fields = { "kind", "abbr", "menu" },

		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				symbol_map = {
					Text = "󰦨",
					Variable = "󰫧",
					Keyword = "",
					Field = "",
				},
			})(entry, vim_item)

			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    [" .. (strings[2] or "") .. "]"

			return kind
		end,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- For nvim-lsp
		{ name = "luasnip" }, -- For luasnip user
		{ name = "buffer" }, -- For buffer word completion
		{ name = "path" }, -- For path completion
		{ name = "nvim_lsp_signature_help" },
	}),
})
