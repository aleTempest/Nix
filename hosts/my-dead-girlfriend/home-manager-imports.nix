{
  inputs, 
  ...
}:
{
  imports = [
    inputs.nix-colors.homeManagerModule
    ../../home-manager-modules/dekstop/theme.nix

    ../../home-manager-modules/programs/lf.nix
    ../../home-manager-modules/programs/tmux.nix
    ../../home-manager-modules/programs/git.nix
    ../../home-manager-modules/programs/fish.nix
  ];
}
