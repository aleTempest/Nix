{
  # Auto login en la TTY
  services.getty.autologinUser = "ale";

  # Sonido
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
