{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./flatpak.nix
      ./shell.nix
      ./kdeconnect.nix
    ];

  boot.loader.grub = {
     efiSupport = true;
     device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "ela";
  networking.wireless.enable = true;
  networking.wireless.networks = {
    INFINITUM9CFF = {
      psk = "hyUKUnANB6";
    };
  };
  # networking.networkmanager.enable = true;

  time.timeZone = "America/Monterrey";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_MX.UTF-8";
    LC_IDENTIFICATION = "es_MX.UTF-8";
    LC_MEASUREMENT = "es_MX.UTF-8";
    LC_MONETARY = "es_MX.UTF-8";
    LC_NAME = "es_MX.UTF-8";
    LC_NUMERIC = "es_MX.UTF-8";
    LC_PAPER = "es_MX.UTF-8";
    LC_TELEPHONE = "es_MX.UTF-8";
    LC_TIME = "es_MX.UTF-8";
  };

  # Activar flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # KDE
  # services.xserver.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  # TTY
  services.getty.autologinUser = "ale";

  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };
  console.keyMap = "la-latin1";

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
      vim
      git
  ];

  # Habilitar docker
  virtualisation.docker.enable = true;

  users.users.ale = {
    isNormalUser = true;
    description = "Agustin Alejandro Mota Hinojosa";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      home-manager
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
    source-han-sans-japanese
    source-han-serif-japanese
    font-awesome
    corefonts
    vistafonts
  ];

  system.stateVersion = "24.11";
}
