{ pkgs, config, ... }:
{
  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {

    enable = true;

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    commands = {
      editorOpen = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
          printf "Dir name: "
          read DIR
          mkdir $DIR
        }}
      '';
    };
  };
}
