{
	description = "System configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		zen-browser.url = "github:0xc000022070/zen-browser-flake";
		catppuccin.url = "github:catppuccin/nix";

		aagl = {
			url = "github:ezKEa/aagl-gtk-on-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, catppuccin, zen-browser, ... }@inputs:
		let
			system = "x86_64-linux";
		in {
		nixosConfigurations.ryo = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [
				./nixos/configuration.nix
				inputs.aagl.nixosModules.default
				{
					environment.systemPackages = [
					  zen-browser.packages."${system}".specific
					];
				}
			];
		};

		homeConfigurations.rap1 = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			
			extraSpecialArgs = { inherit inputs; };

			modules = [ 
				./home-manager/home.nix
				catppuccin.homeManagerModules.catppuccin
				inputs.spicetify-nix.homeManagerModules.default
			];
		};
	};
}
