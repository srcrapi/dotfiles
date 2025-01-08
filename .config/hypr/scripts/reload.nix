{ pkgs ? import <nixpkgs> {} }:

let
	hypr_dir = "$HOME/.config/hypr";
in
pkgs.mkShell {
	buildInputs = with pkgs; [
		python312Packages.pillow
		python312Packages.materialyoucolor
	];

	shellHook = ''
	${hypr_dir}/scripts/reload.sh
	exit
	'';
}
