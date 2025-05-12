{ pkgs, config, ... }:
let
  bluetooth = pkgs.pkgs.writeShellScriptBin "bluetooth" ''
      DEVICE_MAC="98:34:8C:D3:E8:AB"
      connected=$(bluetoothctl info "$DEVICE_MAC" | grep -i "connected: yes")
      
      if [ -n "$connected" ]; then
          bluetoothctl disconnect "$DEVICE_MAC"
      else
          bluetoothctl connect "$DEVICE_MAC"
      fi
  '';
in
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

        #workspaces button {
            padding: 0 10px;
            background-color: transparent;
            color: #${base07};
            margin: 0;
        }
        
        #workspaces button:hover {
            background: #${base0A};
            color: #${base00};
            box-shadow: inherit;
        }
        
        /*#workspaces button.focused {
            background: #${base09};
            color: #${base08};
        }*/

        #workspaces button.active {
            font-weight: 400;
            background: #${base09};
            color: #${base01};
        }
        
        #workspaces button.urgent {
            background-color: #${base0F};
            color: #${base01};
        }
     
        .modules-right,
        .modules-center,
        .modules-left {
          background: #${base00};
          padding: 5px;
        }

        #window {
          color: #${base06};
          padding-left: 5px;
        }

        #clock,
        #cpu,
        #memory,
        #temperature,
        #battery,
        #network,
        #pulseaudio,
        #disk,
        #tray {
          margin-left: 8px;
        }

        #clock {
            color: #${base09};
            border-bottom: 1px solid #${base09};
        }
        
        /*#cpu {
            color: #${base0C};
            border-bottom: 1px solid #${base0C};
        }
        
        #memory {
            color: #${base0B};
            border-bottom: 1px solid #${base0B};
        }
        
        #temperature {
            color: #${base0A};
            border-bottom: 1px solid #${base0A};
        }*/

        /* TODO: estados */
        #battery {
            color: #${base0C};
            border-bottom: 1px solid #${base0C};
        }
        
        #network {
            color: #${base0B};
            border-bottom: 1px solid #${base0B};
        }
        
        #pulseaudio {
            color: #${base0E};
            border-bottom: 1px solid #${base0E};
        }
        
        /*#disk {
            color: #${base06};
            border-bottom: 1px solid #${base06};
        }*/

        #tray {
            background-color: transparent;
            padding: 0 10px;
            margin: 0 2px;
        }
        
        #tray > .passive {
            -gtk-icon-effect: dim;
        }
        
        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            color: @red;
            border-bottom: 1px solid @red;
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

        modules-left = [ "custom/menu" "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ ];
        modules-right = [ "clock" "pulseaudio" "battery" "network" "tray" "custom/ela" ];

        "custom/ela" = {
          format = "ela";
          tooltip = false;
          on-click = "systemctl suspend";
        };

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
          active-only = false;
          all-outputs = true;
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
          persistent-workspaces = {
            "HDMI-A-1" = [ 1 2 3 4 5 6 7 8 ];
            "eDP-1" = [ 9 10 ];
          };
        };

        cpu = {
          format = "󰘚 {usage}%";
          tooltip = true;
          interval = 1;
          on-click = "alacritty -e btop";
        };
      
        memory = {
          format = "󰍛 {}%";
          interval = 1;
          on-click = "alacritty -e btop";
        };
      
        temperature = {
          format = "{icon} {temperatureC}°C";
          format-icons = ["󱃃" "󰔏" "󱃂"];
        };

        tray = {
          spacing = 0;
          icon-size = 20;
        };

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
        };

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
          on-click-middle = "${bluetooth}/bin/bluetooth";
          tooltip = false;
        };

        disk = {
          interval = 30;
          format = "󰋊 {percentage_used}%";
          path = "/home";
        };

        clock = {
          format = "{:%a, %d. %b  %H:%M}";
        };

      }; # mainbar
    }; # settings
  };
}
