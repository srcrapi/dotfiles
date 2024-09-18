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
					"                 __  ",
					"                /  | ",
					" _ __ __ _ _ __ `| | ",
					"| '__/ _` | '_ \\ | | ",
					"| | | (_| | |_) || |_",
					"|_|  \\__,_| .__/\\___/",
					"          | |        ",
					"          |_|        ",
					"",
				},
				center = {
					{
						icon = " ",
						icon_hl = "Title",
						desc = "Find File           ",
						desc_hl = "String",
						key = "f",
						key_hl = "Number",
						key_format = " %s", -- remove default surrounding `[]`
						action = ":Telescope find_files",
					},
					{
						icon = " ",
						desc = "Select Colorscheme",
						key = "c",
						key_format = " %s", -- remove default surrounding `[]`
						action = ":Telescope colorscheme",
					},
				},
				footer = {}, --your footer
			},
		})
	end,
}