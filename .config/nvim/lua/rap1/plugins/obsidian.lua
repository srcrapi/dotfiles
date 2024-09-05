return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "personal",
						path = "~/personal",
					},
				},
				templates = {
					subdir = "templates",
					date_format = "%d-%m-%Y",
					time_format = "%H:%M %S",
				},
				follow_url_func = function(url)
					vim.fn.jobstart({ "xdg-open", url })
				end,
				daily_notes = {
					date_format = "%d-%m-%Y",
				},
				completion = {
					nvim_cmp = true,
					min_chars = 2,
				},
				mappings = {
					-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					-- Toggle check-boxes.
					["<leader>ch"] = {
						action = function()
							return require("obsidian").util.toggle_checkbox()
						end,
						opts = { buffer = true },
					},
				},
			})
		end,
	},
}
