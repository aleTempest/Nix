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
      vi = "~/Nixvim/result/bin/nvim";
      home = "cd ~/ela && vi";
    };
  };

  home.packages =
  (with pkgs; [
    inputs.terminal-rain.packages.${stdenv.hostPlatform.system}.terminal-rain-lightning
    blender
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
    easyeffects
    mpv
    feh
    grc
    vscode
    tauon
    nix-search-cli
    btop
    prismlauncher
    qbittorrent
    unzip
    zip
    inputs.zen-browser.packages."${system}".beta
    discord
    osu-lazer
    opentabletdriver
    gnome-tweaks
    nautilus
    mullvad-vpn
  ]);
    # ++
    # (with inputs.nixpkgs-unstable; [
    #   klassy
    # ]);

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
