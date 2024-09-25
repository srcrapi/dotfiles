return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"cpp",
				"rust",
				"go",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"python",
				"typescript",
				"javascript",
				"astro",
			},

			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			autotag = {
				enable = true,
			},
		})
	end,
}
