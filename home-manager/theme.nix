{ pkgs, inputs, ... }:
{
  gtk = {
    enable = true;

    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3";

    iconTheme.package = pkgs.gnome.adwaita-icon-theme;
    iconTheme.name = "Adwaita";

    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = false;

    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };


}
