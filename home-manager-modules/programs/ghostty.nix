{
  config,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    themes = {
      catppuccin-mocha = {
        background = "${config.colorScheme.palette.base00}";
        cursor-color = "${config.colorScheme.palette.base07}";
        foreground = "cdd6f4";
        palette = with config.colorScheme.palette; [
          "0=#${base00}"
          "1=${base08}"
          "2=${base0B}"
          "3=${base0A}"
          "4=${base0D}"
          "5=${base0E}"
          "6=${base0C}"
          "7=${base05}"
          "8=${base03}"
          "9=${base08}"
          "10=${base0B}"
          "11=${base0A}"
          "12=${base0D}"
          "13=${base0E}"
          "14=${base0C}"
          "15=${base06}"
        ];
        selection-background = "353749";
        selection-foreground = "cdd6f4";
      };
    };
    settings = {
      theme = "catppuccin-mocha";
      font-size = 14;
    };
  };
}
