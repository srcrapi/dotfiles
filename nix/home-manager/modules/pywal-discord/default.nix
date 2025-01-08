{ pkgs, config, lib, ... }:
let
	pywal-discord = pkgs.callPackage ./package.nix {};
in {
	home = {
		activation = {
			createPywalDiscordDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
				mkdir -p "${config.xdg.configHome}/pywal-discord"
				chmod 755 "${config.xdg.configHome}/pywal-discord"
			'';
		};

		packages = [
			pywal-discord
		];
	};
}
