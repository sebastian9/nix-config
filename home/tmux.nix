{
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    # Override the hjkl and HJKL bindings for pane navigation and
    # resizing in VI mode.
    customPaneNavigationAndResize = true;
    shortcut = "a";
    resizeAmount = 20;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"

          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_date_time_text "%H:%M"

          set -g @catppuccin_status_modules_right "session user host date_time"
        '';
      }
      {
        # To enter copy mode: <prefix> [
        # copy to system clipboard: y
        plugin = yank;
        # Make it vim-like
        extraConfig = ''
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
      }
      {
        # Tmux plugin for creating and switching between sessions based on recently accessed directories
        plugin = session-wizard;
        # Keymap C-T
        extraConfig = ''
          set -g @session-wizard 's'
        '';
      }
      # Keep this two at the end to avoid issues
      # Saves sessions as if you never left
      # To clean session cache `rm ~/.tmux/resurrect/*`
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    extraConfig = ''
      # https://discourse.nixos.org/t/tmux-use-bash-instead-defined-zsh-in-home-manager/54763/5
      # https://github.com/tmux-plugins/tmux-sensible/issues/74
      set -g default-command ${pkgs.zsh}/bin/zsh

      # For neovim mouse support
      set -g focus-events on

      # Status bar stays out of vim's way
      set -g status-position top

      # Alt vim keys to switch windows
      bind -n M-p previous-window
      bind -n M-n next-window

      # Alt vim keys to switch sessions
      bind -n M-P switch-client -p
      bind -n M-N switch-client -n

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # New panes started in $cwd
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
