{ pkgs, ...}:
let
  variant = "Mocha";
  accent = "Flamingo";

  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
in 
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";

    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-${variant}-${accent}
  '';

  "Kvantum/Catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/Catppuccin-${variant}-${accent}";
  };
}
