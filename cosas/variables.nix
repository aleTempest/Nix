{
  self,
  lib,
  ...
}:
{
  options.flake.variables = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };
  config.flake.variables = {
    username = "ale";
  };
}
