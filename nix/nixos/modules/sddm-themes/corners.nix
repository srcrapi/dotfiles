{ pkgs }:

let
  imgLink = "https://images7.alphacoders.com/129/1293921.png";
  imgLink2 = "https://images8.alphacoders.com/135/thumb-1920-1353872.jpeg";

  avatarLink = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapercave.com%2Fwp%2Fwp11814613.png";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-0YVFJ1v8zjH101NiKoCXDeNNxn32UzmpBzs4ztr+2FY=";
  };

  image2 = pkgs.fetchurl {
    url = imgLink2;
    hash = "sha256-zMYRQIy9Z5tRNCwK+5en3uckrNtFfDRLqxQ23V4eHHM=";
  };

  avatar = pkgs.fetchurl {
    url = avatarLink; 
    sha256 = "sha256-da7LIIzLoZDZBdcPbcOeekprPaGQzp8+knL3SStTeIw=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme-corners";

  src = pkgs.fetchFromGitHub {
    owner = "aczw";
    repo = "sddm-theme-corners";
    rev = "6ff0ff455261badcae36cd7d151a34479f157a3c";
    sha256 = "0iiasrbl7ciyhq3z02la636as915zk9ph063ac7vm5iwny8vgwh8";
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./corners/* $out/
    rm $out/backgrounds/glacier.png
    cp -aR ${image} $out/backgrounds/glacier.png
  '';
}
