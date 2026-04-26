{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    historyLimit = 100000;
    mouse = true;
    keyMode = "vi";
    prefix = "C-Space";
    terminal = "alacritty";

    plugins = with pkgs;
    [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.onedark-theme;
        extraConfig = ''
          # set -g @plugin 'odedlaz/tmux-onedark-theme'
        '';
      }
    ];

    extraConfig = with config.colorScheme.palette; ''
      set -ag terminal-overrides ",$TERM:RGB"
      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D 
      bind k select-pane -U
      bind l select-pane -R
      
      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on
      
      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-l select-pane -L
      bind -n M-h select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window
      
      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      bind C-l send-keys 'C-l'

      set -g status-style "fg=#${base07},bg=#${base00}"
    '';
  };
}
