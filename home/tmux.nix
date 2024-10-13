{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    resizeAmount = 10;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-show-powerline true
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
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
