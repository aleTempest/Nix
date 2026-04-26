{
pkgs,
...
}:
{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
  };

  services.flatpak.packages = [
    { appId = "com.spotify.Client"; origin = "flathub"; }
    { appId = "com.discordapp.Discord"; origin = "flathub"; }
    { appId = "dev.vencord.Vesktop"; origin = "flathub"; }
    { appId = "com.obsproject.Studio"; origin = "flathub"; }
    { appId = "com.valvesoftware.Steam"; origin = "flathub"; }
  ];
}
