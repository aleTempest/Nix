{ pkgs, ...}:
  pkgs.stdenv.mkDerivation {
    name = "Moga Purple";
    src = pkgs.fetchFromCodeberg {
      owner = "ale_default";
      repo = "silly-gay-and-nonbinary-cursor";
      rev = "ad3126f68ad95062efc7f47ef218b5ee04b12979";
      sha256 = "sha256-YbTMl7JVwaCBgy0demg0YqH1IAI0imu1mQ8/PXeQIvs=";
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons/Moga-Purple
      cp -dr Moga-Purple/* $out/share/icons/Moga-Purple/

      runHook postInstall
    '';
  }
