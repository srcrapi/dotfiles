return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				layout_config = {
					vertical = { width = 0.5 },
				},
			},
			pickers = {
				find_files = {
					theme = "dropdown",
				},
			},
		})
	end,
}
