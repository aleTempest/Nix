{
  # Wifi declarativo, también existe networkmanager como alternativa.
  networking.hostName = "ela";
  networking.wireless.enable = true;
  networking.wireless.networks = {
    INFINITUM9CFF = {
      psk = "hyUKUnANB6";
    };
  };

  # networking.networkmanager.enable = true;
}
