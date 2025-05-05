return {
	"mhartington/formatter.nvim",
	config = function()
		local util = require("formatter.util")

		require("formatter").setup({
			filetype = {
				javascript = {
					require("formatter.filetypes.javascript").biome,
				},
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").biome,
				},
				typescript = {
					require("formatter.filetypes.typescript").biome,
				},
				typescriptreact = {
					require("formatter.filetypes.typescriptreact").biome,
				},
				json = {
					require("formatter.filetypes.json").biome,
				},
				css = {
					require("formatter.filetypes.css").prettier,
				},
				astro = {
					function()
						return {
							exe = "prettier",
							args = {
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--parser",
								"astro",
							},
							stdin = true,
							try_node_modules = true,
						}
					end,
				},
				lua = { require("formatter.filetypes.lua").stylua },
				python = { require("formatter.filetypes.python").ruff },
				go = { require("formatter.filetypes.go").goimports },
				sql = {
					function()
						return {
							exe = "sqlfmt",
							args = {
								"-",
							},
							stdin = true,
						}
					end,
				},
			},
		})
	end,
}
