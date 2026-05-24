{
  inputs,
  ...
}:
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];
  programs.plasma = {
    enable = true;
    # workspace = {
    #   cursor.theme = "Bibata-Modern-Ice";
    #   iconTheme = "Kora-Dark";
    # };
    panels = [
      {
        alignment = "left";
        height = 50;
        lengthMode = "fill";
        location = "left";
        opacity = "translucent";
        widgets = [
          {
            name = "AndromedaLauncher";
            config = {
              launcherPosition = 3;
            };
          }
          {
            name = "org.dhruv8sh.kara";
            config = {
              general = {
                animationDuration = 0;
                highlightType = 1;
                spacing = 3;
                type = 1;
              };
              type1 = {
                fixedLen = 3;
                labelSource = 0;
              };
            };
          }
          "org.kde.plasma.icontasks"
          {
            panelSpacer = {
              expanding = true;
            };
          }
          {
            panelSpacer = {
              expanding = true;
            };
          }
          {
            systemTray = {
              icons.scaleToFit = true;
              items = {
                showAll = false;
                shown = [
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.mediacontroller"
                  "plasmashell_microphone"
                  "xdg-desktop-portal-kde"
                ];
                hidden = [
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.devicenotifier"
                ];
              };
            };
          }
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                autoFontAndSize = true;
                customDateFormat = "ddd, MMM dd";
                dateDisplayFormat = "BesideTime";
                dateFormat = "custom";
                use24hFormat = 2;
              };
            };
          }

        ];
      }
    ];
  };
}
