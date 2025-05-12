{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./bootloader.nix
      ./net.nix
      ./lang.nix
      ./services.nix
      ./flatpak.nix
      ./shell.nix
      ./kdeconnect.nix
      ./syncthing.nix
    ];


  # Activar flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
      vim
      git
  ];

  # Habilitar docker
  virtualisation.docker.enable = true;

  users.users.ale = {
    isNormalUser = true;
    description = "Agustin Alejandro Mota Hinojosa";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      home-manager
    ];
  };

  fonts.packages = with pkgs; [
    # goated
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })

    # Fuentes para japonés, chino
    source-han-sans-japanese
    source-han-serif-japanese
    noto-fonts-cjk-sans

    # íconos
    font-awesome
    
    # Fuentes de microsoft
    corefonts
    vistafonts

    # emojis
    noto-fonts-emoji
  ];

  programs.dconf.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  system.stateVersion = "24.11";
}
