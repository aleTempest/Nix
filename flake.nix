{
  description = "ela";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    niri = {
      url = "github:myume/niri-flake/blur";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.niri-unstable.url = "github:YaLTeR/niri";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ ./cosas ];
    };
}
