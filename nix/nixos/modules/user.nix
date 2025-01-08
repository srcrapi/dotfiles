{ pkgs, ...}: {
	programs.fish.enable = true;

	users = {
		defaultUserShell = pkgs.fish;

		users.rap1 = {
			isNormalUser = true;
			extraGroups = ["networkmanager" "wheel" "input" ];
			packages = with pkgs; [];
		};
	};
}
