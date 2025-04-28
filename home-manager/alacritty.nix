{ pkgs, config, inputs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {

      font = {
        normal = {
          family = "Iosevka Nerd Font";
          style = "Normal";
        };
        size = 13;
      };

      window = {
        padding = {
          x = 12;
          y = 12;
        };
        opacity = 0.9;
      };

      terminal.shell = "fish";

      # base 16
      colors = with config.colorScheme.palette; {
        primary = {
          background = "0x${base00}";
          foreground = "0x${base06}";
        };

        cursor = {
          text = "0x${base06}";
          cursor = "0x${base06}";
        };

        vi_mode_cursor = {
          text = "0x${base06}";
          cursor = "0x${base06}";
        };

        selection = {
          text = "0x${base03}";
          background = "0x${base06}";
        };

        normal = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base0A}";
        };

        bright = {
          black = "0x${base03}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base09}";
        };

        dim = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base09}";
        };
      };
    };
  };
}
