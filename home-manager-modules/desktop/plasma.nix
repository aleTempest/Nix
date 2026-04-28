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
    panels = [
      {
        alignment = "center";
        height = 30;
        lengthMode = "fill";
        location = "top";
        opacity = "translucent";
        widgets = [
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
          {
            panelSpacer = {
              expanding = true;
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
                ];
                hidden = [
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.mediacontroller"
                  "plasmashell_microphone"
                  "xdg-desktop-portal-kde"
                ];
              };
            };
          }
        ];
      }
    ];
  };
}
