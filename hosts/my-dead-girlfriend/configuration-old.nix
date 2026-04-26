{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ./lang.nix
      ./services.nix
      #./flatpak.nix
      ./shell.nix
      # ./plasma6.nix
      # ./syncthing.nix
    ];

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # como alternativa esta otro manager que maneja las redes de manera
  # declarativa
  networking.networkmanager.enable = true;

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
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
      ani-cli
    ];
  };

  fonts.packages = with pkgs; [
    wl-clipboard
    ntfs3g  
    vulkan-tools
    vulkan-loader
    mesa-demos
    # goated
    # (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.lilex

    # Fuentes para japonés, chino
    # source-han-sans-japanese
    source-han-sans
    source-han-serif
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # íconos
    font-awesome

    # Fuentes de microsoft
    corefonts
    vista-fonts

    # emojis
    #noto-fonts-emoji

    inter
  ];

  programs.dconf.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  programs.steam.enable = true;

  system.stateVersion = "25.11";
}
