{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: 
let
  system = "x86_64-linux";
in
{
  imports = [
    inputs.nix-colors.homeManagerModule
    ./alacritty.nix
    ./tmux.nix
    ./hypr.nix
    ./waybar.nix
    ./wofi.nix
    ./theme.nix
    ./lf.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.oxocarbon-dark;

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "ale";
    homeDirectory = "/home/ale";
    shellAliases = {
      ls = "exa";
      ll = "exa -lha";
      sail = "sh $([ -f sail ] && echo sail || echo vendor/bin/sail)";
      nd = "nix develop";
      nr = "nix run";
      vi = "nix run ~/flakes/nixvim";
      home = "cd ~/ela && vi";
    };
  };

  home.packages = with pkgs; [ 
    spotify
    eza
    wl-clipboard
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

    cinnamon.nemo-with-extensions
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-media-tags-plugin
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName  = "ale";
    userEmail = "ale.edgedancer@gmail.com";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];
  };

  home.stateVersion = "24.11";
}
