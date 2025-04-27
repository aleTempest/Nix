{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "bashtop";
  src = "./src";
  shellHook = ''
    ~/ela/derivations/bashtop/bashtop
  '';
}
