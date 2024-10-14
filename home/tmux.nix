{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    resizeAmount = 20;
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      cpu
      catppuccin
      # C-j C-j C-k & C-j for panel navigation vim included
      vim-tmux-navigator
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
      # Keep this two at the end to avoid issues
      # Saves sessions as if you never left
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
      # Status bar stays out of vim's way
      set -g status-position top

      set -g mouse on

      # Alt vim keys to switch windows
      bind -n M-h previous-window
      bind -n M-l next-window

      # New panes started in $cwd
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
