{
pkgs,
...
}:
{
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
  };

  services.flatpak.packages = [
    { appId = "com.brave.Browser"; origin = "flathub";  }
    { appId = "com.obsproject.Studio"; origin = "flathub"; }
    { appId = "com.discordapp.Discord"; origin = "flathub"; }
    { appId = "com.valvesoftware.Steam"; origin = "flathub"; }
    { appId = "com.github.wwmm.easyeffects"; origin = "flathub"; }
  ];
}
