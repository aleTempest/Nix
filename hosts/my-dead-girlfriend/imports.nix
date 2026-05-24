{
  imports = [
    ../../modules/system/shell.nix
    ../../modules/system/lang.nix
    ../../modules/system/services.nix
    ../../modules/system/bootloader.nix

    # TODO: arreglar xdg-portal
    ../../modules/programs/flatpak.nix
    ../../modules/programs/syncthing.nix

    ../../modules/desktop/plasma6.nix
    ../../modules/desktop/dwm.nix
  ];
}
