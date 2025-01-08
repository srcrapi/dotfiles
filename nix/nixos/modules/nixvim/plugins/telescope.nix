{
	programs.nixvim.plugins.telescope = {
		enable = true;

		keymaps = {
			"<leader>ff" = "find_files";
			"<leader>b" = "buffers";
		};

	};
}
