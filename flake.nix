{
  description = "ela";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    flake-parts.url = "github:hercules-ci/flake-parts";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    terminal-rain.url = "github:delta-psi/terminal-rain-lightning-flake";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    moga-purple-cursors.url = "git+https://codeberg.org/ale_default/Moga-Purple-Flake";
};

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ ./cosas ];
    };
}
