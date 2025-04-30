{ pkgs, ... }:
{
  gtk = {
    enable = true;
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
