{ 
  pkgs,
  lib,
  config,
  inputs,
  ... 
}:
let
  zenMode = pkgs.pkgs.writeShellScriptBin "zen_mode" ''
    if pgrep waybar; then
      pkill waybar
      hyprctl keyword general:gaps_in 0
      hyprctl keyword general:gaps_out 0
      hyprctl keyword decoration:rounding 0
      hyprctl keyword animations:enabled "no"
    else
      waybar & disown
      hyprctl keyword general:gaps_in 5
      hyprctl keyword general:gaps_out 5
      hyprctl keyword decoration:rounding 2
      hyprctl keyword animations:enabled "yes"
    fi
    '';
  
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    # TODO Iniciar discord, steam y navegador.
    # TODO Asignar cada aplicación a un workspace específico.
    # hyprctl setcursor Bibata-Modern-Ice 16 & 
    ${pkgs.waybar}/bin/waybar & 
    sleep 1
    ${pkgs.waypaper}/bin/waypaper --restore &
    blueman-applet &
  '';
in
{
  imports = [
    inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
  ];

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.hyprcursor-phinger.enable = true;

  home.packages = with pkgs; [
    wofi
    rofi-wayland
    hyprlock
    swaybg
    waypaper
    swaynotificationcenter
    slurp
    grim
    swappy
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    extraConfig = ''
      bind = ,Print, exec, grim -g "$(slurp)" - | swappy -f - 
    '';

    settings = {
      env = "XCURSOR_SIZE, 24";

      monitor = [
        "HDMI-A-1,preferred,1920x0,auto"
        "eDP-1,1920x1080,0x370,1"
      ];

      workspace = [
        "9,monitor:eDP-1"
        "10,monitor:eDP-1"

        # smart gaps, por alguna razón quitaron `no_gaps_when_only` de dwindle
        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      windowrule = [
        "noblur,tittle:Picture in Picture"
        "noshadow,class:Chromium-browser"
        "noblur,class:Chromium-browser"
        "noblur,class:Xdg-desktop-portal-gtk"
        "noshadow,class:Xdg-desktop-portal-gtk"
      ];

      windowrulev2 = [

        "noblur,class:^()$,title:^()$"

        "bordersize 0, floating:0, onworkspace:w[t1]"
        "rounding 0, floating:0, onworkspace:w[t1]"
        "bordersize 0, floating:0, onworkspace:w[tg1]"
        "rounding 0, floating:0, onworkspace:w[tg1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];

      exec-once = ''${startupScript}/bin/start'';

      # Activar la layout dwindle
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      input = {
        # definir layouts del teclado
        kb_layout = "latam, us";

        # cambiar caps por esc
        kb_options = "caps:swapescape,grp:rctrl_toggle";

        follow_mouse = 1;

        # invertir el scroll del touchpad
        touchpad = {
          natural_scroll = "yes";
        };
      };

      gestures = {
        workspace_swipe = "on";
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 3;
        "col.inactive_border" = "rgba(00000000)";
        "col.active_border" = "rgba(${config.colorScheme.palette.base07}ee)";
      };

      decoration = {
        rounding = 0;
        active_opacity = 0.9;
        inactive_opacity = 0.7;
        shadow = {
          enabled = true;
          range = 6;
          render_power = 2;
          color = "0x44000000";
        };
        blur = {
          enabled = true;
          size = 12;
          new_optimizations = true;
          ignore_opacity = true;
          passes = 3;
          popups = true;
          xray = true;
        };
      };

      animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
      };

      "$mod" = "SUPER";
      "$alt" = "Mod1";
      "$term" = "alacritty";
      "$browser" = "floorp";
      "$menu" = "wofi --show drun";

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      binde = [
        # volumen
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bind =
        [
          "$alt, b, exec, chromium --ozone-platform-hint=auto --ozone-platform=wayland"
          # toggle zenMode
          # "$mod, Z, exec, ${zenMode}/bin/zen_mode"

          # fullscreen
          "$mod, F, fullscreen,"

          # volumen
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # brillo
          ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
          ",XF86MonBrightnessUp,exec,brightnessctl set +5%"

          # movimiento
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # scroll en worspace
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # programas
          "$alt, SPACE, exec, $menu"
          "$mod, Q, exec, $terminal"
          "$mod, W, killactive, "
          "$mod, M, exit, "
          "$mod, E, exec, $fileManager"
          "$mod, V, togglefloating, "
          "$mod, P, pseudo, # dwindle"
          "$alt, E, exec, nemo"
          "$alt, W, exec, waypaper"
          "$mod, Q, exec, $term"
        ]
        ++ (
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
}
