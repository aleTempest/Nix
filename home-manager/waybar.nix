{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    waybar
    rubik
  ];

  programs.waybar = {
    enable = true;

    style = with config.colorScheme.palette; ''
        * {
          font-family: Rubik;
          font-size: 13px;
          min-height: 0;
        }
      
        window#waybar {
          background: #${base00};
        }
      
        .modules-right,
        .modules-center,
        .modules-left {
          color: #${base07};
          background: #${base00};
          margin: 5px;
        }
      
        .modules-right * {
          margin-left: 10px;
        }
      
        /* Workspaces */
        #workspaces button {
          margin: 5px;
          border-radius: 0;
          background: transparent;
          color: #${base07};
        }
      
        #workspaces button.focused,
        #workspaces button.active {
          color: #${base0A};
        }
      
        /* Module containers */
        #workspaces,
        #clock,
        #pulseaudio,
        #battery,
        #network {
          background: #${base02};
          border-radius: 10px;
          padding: 3px;
        }
      
        /* Individual modules */
        #custom-menu {
          color: #${base08};
          margin-right: 10px;
        }
      
        #network {
          color: #${base0E};
        }
      
        #pulseaudio {
          color: #${base0D};
        }
      
        #battery {
          color: #${base0C};
        }
      
        #clock {
          color: #${base0A};
        }
      
        #window {
          color: #${base09};
          margin-left: 15px;
        }
      
        #mode {
          margin-left: 30px;
        }
    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 10;

        output = [
          "eDP-1"
            "HDMI-A-1"
        ];

        modules-left = [ "custom/menu" "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "battery" "network" "tray" ];

        "custom/menu" = {
          format = "";
          tooltip = false;
          on-click = "~/.config/rofi/powermenu/type-1/powermenu.sh";
          on-click-right = "~/.config/rofi/launchers/type-1/launcher.sh";
        };

        "hyprland/window" = {
          max-lenght = 40;
          separate-outputs = true;
        };

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = false;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
        }; # workspaces

        tray = {
          spacing = 0;
          icon-size = 20;
        }; # tray

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
          tooltip-format = "{capacity}% - {timeTo}";
        }; # battery

        network = {
          format-wifi = "{essid}  ";
          format-disconnected = "✕";
          tooltip-format = "{ifname} via {gwaddr}  ";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
          tooltip-format-ethernet = "{ifname}  ";
          tooltip-format-disconnected = "Disconnected";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{volume}% {icon} ";
          format-muted = "Muted  ";
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = "";
            default = [
              " " 
              " "
            ];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
          on-click-middle = "amixer set Master toggle";
          tooltip = false;
        }; # pulseaudio

        clock = {
          format = "{:%a, %d. %b  %H:%M}";
        }; # clock
      }; # mainbar
    }; # settings
  };
}
