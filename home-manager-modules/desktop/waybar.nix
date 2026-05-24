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
    #backlight, #battery, #cpu, #disk, #idle_inhibitor, #keyboard-state,
    #pulseaudio, #clock, #tags, #language, #memory, #network, #sndio,
    #mode, #window, #workspaces, #temperature, #taskbar, #workspaces,
    * {
      font-family: "Lilex Nerd Font";
      font-size: 17px;
    }

    window#waybar { 
      background-color: #${base09}; 
      color: #${base00};
      font-size: 12px;
    }

    .modules-left {
      background-color: #${base00}; 
      color: #${base09};
    }
    
    .modules-center {
      background-color: #${base09};
      color: #${base00};
    }
    
    .modules-right {
      background-color: #${base00}; 
      color: #${base09};
    } 
    
    #workspaces {
      font-size: 20px;
      border-radius: 0px;
    }
    
    #workspaces button {
      font-size: 13px;
      padding: 0px 8px 0px 8px; 
      min-width: 1px;
      border-radius: 0px;
    }
    
    #workspaces button.empty {
      color: #${base09};
    }
    
    #workspaces button.visible {
      font-size: 20px;
      padding: 0px 8px 0px 8px; 
      min-width: 1px;
      color: #ea6962;
    }
    
    #workspaces button.focused { 
      font-size: 20px;
      padding: 0px 8px 0px 8px; 
      padding: 0px 8px 0px 8px; 
      background-color: #${base09}; 
      color: #${base00};    
    }
    
    #workspaces button.active {
      font-size: 20px;
      padding: 0px 8px 0px 8px; 
      background-color: #${base09}; 
      color: #${base00};    
    }

    #custom-nowplaying,#window {
      font-size: 18px;
      color: #${base00};
      background-color: #${base09};
      padding: 0px 10px 0px 10px;
    }
    
    
    window#waybar.empty #window {
      font-size: 13px;
      background-color: transparent;
      color: transparent;
    }
    
    
    window#waybar.empty {
      font-size: 13px;
      background-color: #${base00};
    }

    #custom-ela {
      padding-left: 2px;
    }

    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 10;

        output = [
          "DP-1"
          "HDMI-A-1"
        ];

        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ ];
        modules-right = [ "clock" "tray" "custom/ela" ];

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
            "DP-1" =  [ 1 2 3 4 5 6 7 8 ];
            "HDMI-A-1" = [ 9 10 ];
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
