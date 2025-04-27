{ pkgs, lib, config, ... }:
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
    ${pkgs.waybar}/bin/waybar & 
    sleep 1
    ${pkgs.waypaper}/bin/waypaper --restore &
  '';
in
{
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

    settings = {
      env = "XCURSOR_SIZE, 24";

      exec-once = ''${startupScript}/bin/start'';

      # Activar la layout dwindle
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        # no_gaps_when_only = 1; # equivalente a smart gaps
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
        gaps_in = 5;
        gaps_out = 5;
        "col.inactive_border" = "rgba(${config.colorScheme.palette.base00}ee)";
        "col.active_border" = "rgba(${config.colorScheme.palette.base0A}ee)";
        border_size = 2;
      };

      decoration = {
          rounding = 2;
          blur = {
              enabled = true;
              size = 10;
              passes = 1;
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
          "$alt, F, exec, $browser"
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

    extraConfig = ''
      monitor=HDMI-A-1,preferred,0x0,auto
      monitor=eDP-1,disable
      # monitor=eDP-1,1920x1080,1920x500,1.25
      bind = ,Print, exec, grim -g "$(slurp)" - | swappy -f - 
    '';

  };

}
