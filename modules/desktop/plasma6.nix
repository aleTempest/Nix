{
  pkgs,
  ...
}:
{
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = false;
  services.displayManager.sddm.wayland.enable = true;

  environment.systemPackages = with pkgs;
    [
      kdePackages.xdg-desktop-portal-kde
      kdePackages.discover 
      kdePackages.kcalc 
      kdePackages.kcharselect 
      kdePackages.kcolorchooser 
      kdePackages.kolourpaint 
      kdePackages.ksystemlog 
      kdePackages.sddm-kcm 
      kdiff3 
      kdePackages.isoimagewriter 
      kdePackages.partitionmanager 
      hardinfo2 
      haruna 
      wayland-utils 
      wl-clipboard 
    ];

  programs.kdeconnect.enable = true;
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; }
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; }
    ];  
  };  

}
