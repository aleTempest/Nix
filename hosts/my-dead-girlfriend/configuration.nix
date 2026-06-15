{
  username,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware-configuration.nix
    ./imports.nix
  ];

  networking.hostName = "nixos";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
      vim
      git
      wl-clipboard
      ntfs3g  
      vulkan-tools
      vulkan-loader
      mesa-demos
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      home-manager
      ani-cli
    ];
  };

  programs.steam.enable = true;

  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.lilex
    nerd-fonts.envy-code-r

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
    reaper
  ];

  programs.dconf.enable = true;

  programs.obs-studio.enable = true;
  programs.obs-studio.enableVirtualCamera = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "26.05";
}
