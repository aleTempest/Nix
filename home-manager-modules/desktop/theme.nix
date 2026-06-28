{ pkgs, inputs, ... }:
let
  mogaPurple = import ../../derivations/moga.nix { inherit pkgs; };
in
{
  colorScheme = inputs.nix-colors.colorSchemes.oxocarbon-dark;

  home.pointerCursor =  {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Moga-Purple";
    package = mogaPurple;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
