{ pkgs, inputs, ... }:
{
  colorScheme = inputs.nix-colors.colorSchemes.oxocarbon-dark;
  gtk = {
    enable = false;
    theme = {
      package = pkgs.fluent-gtk-theme;
      name = "Fluent-Dark";
    };

    iconTheme = {
      package = pkgs.fluent-icon-theme;
      name = "Fluent-dark";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
