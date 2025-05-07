{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "ale";
    dataDir = "/home/ale";
    configDir = "/home/ale/.config/syncthing";

    settings.gui = {
      user = "ale";
      password = "elaina";
    };

    devices = {
      "POCOM6" = { id = "T5SWMAT-3VP52UE-WKFNP3O-3OBJ5VD-6AEOG56-VQR4LCR-XD5HHRD-2NARIQY"; };
    };

    folders = {
      "Pictures" = {
        path = "/home/ale/Pictures";
        devices = [ "POCOM6" ];
      };
    };
  };
}
