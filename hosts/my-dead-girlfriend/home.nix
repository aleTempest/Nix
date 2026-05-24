{
  username,
  pkgs,
  inputs,
  ...
}:
let
  system = "x86_64-linux";
in
{
  imports = [ ./home-manager-imports.nix ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    shellAliases = {
      ls = "exa";
      ll = "exa -lha";
      sail = "sh $([ -f sail ] && echo sail || echo vendor/bin/sail)";
      nd = "nix develop";
      nr = "nix run";
      vi = "nix run ~/Nixvim";
      home = "cd ~/ela && vi";
    };
  };

  home.packages =
  (with pkgs; [
    inputs.terminal-rain.packages.${stdenv.hostPlatform.system}.terminal-rain-lightning
    blender
    lutris
    bottles
    plasma-panel-colorizer
    kara
    kdePackages.kpmcore
    kdePackages.partitionmanager
    spotify
    zed-editor
    vesktop
    eza
    wl-clipboard
    feh
    obsidian
    librum
    zathura
    neofetch
    easyeffects
    blueman
    mpv
    feh
    grc
    vscode
    tauon
    nix-search-cli
    duckstation
    btop
    brave
    prismlauncher
    qbittorrent
    unzip
    zip
    brightnessctl
    pavucontrol
    inputs.zen-browser.packages."${system}".beta
    bluez-tools
    chromium
    discord
  ]);
    # ++
    # (with inputs.nixpkgs-unstable; [
    #   klassy
    # ]);

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
