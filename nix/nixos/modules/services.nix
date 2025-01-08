{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;

      xkb.layout = "us";
      xkb.variant = "";

      videoDrivers = ["amdgpu"];
    };

    displayManager.sddm = {
      enable = true;
      theme = "${import ./sddm-themes/corners.nix { inherit pkgs; }}";
	  settings = {
		Users = {
			FacesDir = "/var/lib/user-avatars/";
		};
	  };
    };

    blueman = {
      enable = true;
    };

    openssh.enable = true;
    flatpak.enable = true;

	# mysql

	mysql = {
		enable = true;
		package = pkgs.mariadb;
	};
  };
}
