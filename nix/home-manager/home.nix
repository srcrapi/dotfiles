{ config, pkgs, lib, ... }: {
	imports = [
		./fish.nix
		./modules/bundles.nix
	];

	home = {
		username = "rap1";
		homeDirectory = "/home/rap1";
		stateVersion = "24.05";

		file = 
		let
			symlink = config.lib.file.mkOutOfStoreSymlink;
			home_dir = config.home.homeDirectory;
		in {
			".config/hypr/hyprlock.conf".source = symlink "${home_dir}/.github/dotfiles/.config/hypr/hyprlock.conf";
			".config/hypr/scripts".source = symlink "${home_dir}/.github/dotfiles/.config/hypr/scripts";
			".config/rofi".source = symlink "${home_dir}/.github/dotfiles/.config/rofi";
			".config/nvim".source = symlink "${home_dir}/.github/dotfiles/.config/nvim";
		};
	};

}
