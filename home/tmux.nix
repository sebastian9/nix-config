{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    resizeAmount = 10;
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      cpu
      vim-tmux-navigator
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-powerline true
        '';
      }
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
      set -g status-position top
    '';
  };
}
