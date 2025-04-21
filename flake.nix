{
  description = "Your new nix config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    ...
    } @ inputs: let
      inherit (self) outputs;
    in {
      nixosConfigurations = {
        ale = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "ale@ela" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [./home-manager/home.nix];
        };
      };
    };
}
