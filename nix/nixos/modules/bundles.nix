{
  imports = [
	./env.nix
	./user.nix
	./hyprland.nix
	./bluetooth.nix
	./sddm-avatar.nix
	./services.nix
	./gpg.nix
	./cachix.nix

	# gaming
	./aagl.nix
	./steam.nix
	./gaming.nix
  ];
}
