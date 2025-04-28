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

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = false;

    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
