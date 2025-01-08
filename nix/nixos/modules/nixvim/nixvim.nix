{
  imports = [
    ./opts.nix
		./keymaps.nix
		./plugins/bundle.nix
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
		colorschemes.catppuccin.enable = true;

		autoCmd = [
			{
				event = [ "VimEnter" ];
				command = ":TransparentEnable";
			}
		];
  };
}
