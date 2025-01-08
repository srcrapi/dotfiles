{ pkgs, ... }: 
let
  tela-circle-dracula = (pkgs.tela-circle-icon-theme.override { colorVariants = [ "dracula" ]; }); 
in 
{
  gtk = {
    enable = true;

    catppuccin.enable = true;
    theme.name = "catppuccin-mocha-mauve-standard";
	#theme.name = "Catppuccin-Mocha-Standard-Mauve-Dark";

    iconTheme = {
      package =  tela-circle-dracula;
      name = "Tela-Circle-Dracula";
    };
  };
}
