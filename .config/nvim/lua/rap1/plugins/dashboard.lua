return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				header = {
					"⣿⣿⣿⣿⣿⣿⣿⣿⡿⢻⣿⣿⣿⡞⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
					"⣿⣿⣿⣿⣿⣿⣿⣿⡇⠨⣿⣿⣿⣧⠘⣿⣿⣿⣿⣞⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
					"⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠼⣿⣿⣿⡄⠘⢿⣿⣿⣿⡬⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
					"⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠐⠹⣿⣿⣧⠀⠈⢻⣿⣿⣧⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
					"⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢁⠹⣿⣿⡄⠀⠀⠙⢿⣿⡆⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
					"⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⢂⠘⢿⣷⠀⠀⠀⠀⠙⢿⣈⣤⣤⣶⣾⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⡻⣿",
					"⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠠⠀⠙⠧⠀⠐⢀⡾⠛⣻⣿⣙⣿⣿⣷⡄⠘⣿⣿⣿⣿⣿⣿⣿⣧⡖⠈",
					"⣿⣿⣿⣿⢿⣿⣿⣿⣿⡦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⣿⠟⢋⢀⡅⠀⡇⠀⣿⣿⣿⣿⣿⣿⣿⣿⠂⠈",
					"⣿⣿⣿⣿⡞⣿⣿⣿⣿⣿⣿⣿⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢄⠀⠉⣀⠐⠀⠀⢹⣿⣿⣿⣿⣿⣾⡟⠠⠁",
					"⣿⣿⣿⣿⣧⣸⣿⣿⣿⡿⠯⠻⠳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⢸⣿⣿⣿⣿⣿⡟⡇⡆⢠",
					"⣿⣿⣿⣿⣿⣏⠻⠉⠘⡇⠒⠜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⢿⣿⣿⣿⡟⠁⠀⢀⣾",
					"⠛⢻⣿⣿⣿⣿⡄⠀⠀⠈⠂⠂⠈⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠏⠸⠟⠋⢸⣿⣿⣿⣿⣿",
					"⠀⣾⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿",
					"⢀⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿",
					"⣼⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⢀⠔⣿⣿⣿⣿⣿⣿⣿⣿",
					"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠘⠇⠀⠀⠀⠀⠂⠀⠀⠀⠀⢀⠔⠁⠀⣿⣿⣿⣿⣿⣿⡛⡏",
					"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣄⣀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⡀⠀⠁⠀⠀⠀⢻⣿⣿⡿⠟⠊⠀⠀",
					"⠈⠻⠏⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣷⣦⣤⣀⡀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⢸⠻⢿⣧⠀⠀⠀⢀",
					"⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣧⠙⠈⠻⢿⣧⠉⠛⠿⣿⡟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠐⡉⠓⠀⠀⠂",
					"⠀⠀⠀⠀⣿⣿⣹⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⢀⡿⠀⠈⠐⠠⠀⣀⠀⠀⠀⠀⠀⡠⠁⠀⠐⡄⠤⡐⣀",
					"",
				},
				center = {
					{
						icon = " ",
						icon_hl = "Title",
						desc = "find file                ",
						desc_hl = "String",
						key = "f",
						key_hl = "Number",
						key_format = " %s", -- remove default surrounding `[]`
						action = ":Telescope find_files",
					},
					{
						icon = " ",
						desc = "select colorscheme",
						key = "c",
						key_format = " %s", -- remove default surrounding `[]`
						action = ":telescope colorscheme",
					},
					{
						icon = "󰈆 ",
						desc = "quit",
						key = "q",
						key_format = " %s", -- remove default surrounding `[]`
						action = ":qa",
					},
				},
				footer = {}, --your footer
			},
		})
	end,
}
