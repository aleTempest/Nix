{
  description = "ela";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-flatpak,
    #plasma-manager,
    ...
    } @ inputs: let
      pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
      outputs = self.outputs;
    in {
      nixosConfigurations = {
        ale = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs pkgs-unstable;};
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "ale@ela" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs outputs pkgs-unstable;};
          modules = [./home-manager/home.nix];
        };
      };
    };
}
