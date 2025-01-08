{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    configPath = "$HOME/.config/rofi/config.rasi";

    plugins = [ pkgs.rofi-emoji pkgs.rofi-calc ];
  };

  home.file = {
    ".config/wal/templates/rofi-colors.rasi".source = ./rofi-colors.rasi;
  };
}
