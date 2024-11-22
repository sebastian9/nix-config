{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cd = "z";
      cat = "bat";
      ll = "ls -l";
      cl = "clear";
      wcl = "wc -l";
      gdl = "git diff HEAD^ HEAD";
      gci = "git commit --interactive";
      fvim = "nvim $(fzf)";
      fenv = "printenv | fzf";
      falias = "alias | fzf";
      tma = "tmux a";
      lg = "lazygit";
      editc = "cd \"$CONFIG_DIR\" && nvim";
      cdc = "cd $CONFIG_DIR";
      update = lib.mkDefault ''
        cd $CONFIG_DIR && git add -A && sudo nixos-rebuild switch --flake "$CONFIG_DIR#dell" && cd -
      '';
      update-no-cache = lib.mkDefault ''
        cd $CONFIG_DIR && git add -A && sudo nixos-rebuild switch --flake "$CONFIG_DIR#dell" --no-eval-cache && cd -
      '';
      deploy = ''
        nix run "$CONFIG_DIR" -- -p zima nuc
      '';
      backup = ''
        sudo mount /dev/sda /mnt/usb &&
        sudo rsync -av --i-r --progress --no-owner --no-group /mnt/synology/ /mnt/usb/backup
      '';
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    initExtra = ''
      # programs.zoxide init option wasn't working
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';
  };
}
