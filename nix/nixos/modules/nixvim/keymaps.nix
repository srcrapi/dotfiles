{ config, lib, ... }: {
	programs.nixvim = {
		globals = {
			mapleader = " ";
			maplocalleader = " ";
		};

		keymaps = let
			normal =
				lib.mapAttrsToList
				(key: action: {
					mode = "n";
					inherit action key;
				})
				{
					# open/close neo-tree
					"<leader>e" = ":Neotree toggle<CR>";

					# clear search results
					"<esc>" = ":noh<CR>";

					# change windows
					"<C-h>" = "<C-w>h";
					"<C-j>" = "<C-w>j";
					"<C-k>" = "<C-w>k";
					"<C-l>" = "<C-w>l";
				};

			visual = 
				lib.mapAttrsToList
				(key: action: {
					mode = "v";
					inherit action key;
				})
				{
					"K" = ":m '<-2<CR>gv=gv";
					"J" = ":m '>+1<CR>gv=gv";
				};

		in
			config.nixvim.helpers.keymaps.mkKeymaps
			{ options.silent = true; }
			(normal ++ visual);
	};
}
