{ pkgs, lib, inputs, ...}:
let 
	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"spotify"
	];

	programs.spicetify = {
		enable = true;

		enabledCustomApps = with spicePkgs.apps; [ lyricsPlus ];

		enabledExtensions = with spicePkgs.extensions; [
			fullAppDisplay
			history
			adblock
			hidePodcasts
		];

		theme = spicePkgs.themes.sleek;
		#colorScheme = "mocha";
	};
}
