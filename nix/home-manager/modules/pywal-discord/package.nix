{ pkgs ? import <nixpkgs> {} }: 

pkgs.stdenv.mkDerivation rec {
	pname = "pywal-discord";
	version = "1.0.0";

	buildInputs = [
		pkgs.bash
	];

	src = pkgs.fetchFromGitHub {
		owner = "quantumwavves";
		repo = "${pname}";
		rev = "1pjvxl41gix27kc3im4ay7as8gypbxx98a6jv7pnk8z98ji2rasg";
		sha256 = "sha256-T6ssokTpo2nv2dIolHpf1z+k1fGK1DjYPKLHFwjtW94=";
	};

	installPhase = ''
		export TMP_DIR="$out/tmp"

		mkdir -p $out/share/pywal-discord
		mkdir -p $out/bin
		mkdir -p $TMP_DIR

		cd $src

		cp -r ./config/* $out/share/pywal-discord

		sed "s+/usr/share/pywal-discord+$out/share/pywal-discord+g" pywal-discord > $TMP_DIR/pywal-discord
		mv $TMP_DIR/pywal-discord $out/bin/
		chmod +x $out/bin/pywal-discord
	'';

	meta = with pkgs.lib; {
		description = "A script that dynamically generates discord for vencord theme based on the current wal colorscheme";
		license = licenses.gpl3;
		platforms = platforms.linux;
	};
}
