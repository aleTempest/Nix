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
      "moto" = { id = "MQ3YMYD-AGDH643-PIUG77N-MGSOPVS-J5R7CST-36RMZ47-26B7V2H-ETZC2QD"; };
    };

    folders = {
      "cia" = {
        path = "/home/ale/Desktop/cia";
        devices = [ "moto" ];
      };
    };
  };
}
