{
  inputs, 
  ...
}:
{
  imports = [
    inputs.nix-colors.homeManagerModule
    ../../home-manager-modules/desktop/theme.nix
    ../../home-manager-modules/desktop/plasma.nix

    ../../home-manager-modules/programs/ghostty.nix
    ../../home-manager-modules/programs/lf.nix
    ../../home-manager-modules/programs/tmux.nix
    ../../home-manager-modules/programs/git.nix
    ../../home-manager-modules/programs/fish.nix
    
  ];
}
