# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
inputs,
lib,
config,
pkgs,
...
}: {
  imports = [
    inputs.nix-colors.homeManagerModule
    ./alacritty.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.onedark;

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
    };
  };

  home.packages = with pkgs; [ 
    wezterm
    spotify
    eza
    wl-clipboard
    mpv
    iosevka-comfy.comfy
    grc
    vscode
    tauon
    nix-search-cli
    duckstation
    btop
    brave
    prismlauncher
    nerdfonts
    neovim
    noto-fonts-cjk-sans
  ];

  home.file.".config/wezterm/wezterm.lua".text = builtins.readFile ./wezterm.lua;

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
