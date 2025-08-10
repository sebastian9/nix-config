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
      v = "nvim";
      cd = "z";
      cat = "bat";
      ll = "ls -l";
      cl = "clear";
      wcl = "wc -l";
      code = "code .";
      hg = "history | grep";
      gdl = "git diff HEAD^ HEAD";
      gci = "git commit --interactive";
      gstr = "gh pr status";
      gcop = "gh pr checkout";
      prw = "gh pr view --web";
      prv = "gh pr view --comments";
      gdp = "gh pr diff";
      gapr = "gh pr create --web --fill --assignee $GITHUB_USER --base";
      pr-search = "gh pr list --state ALL --search ";
      git-pickaxe = "git log --all --pickaxe-all -S ";
      fvim = "nvim $(fzf)";
      fcamunda = "open -a \"Camunda Modeler\" $(fzf)";
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
      jira = ''
        firefox "https://issues.teslamotors.com/browse/$(git_current_branch | grep -Eoi 'RESI-\d+')";
      '';
      feel = "amm --predef ~/.config/feel/feel-repl.sc";
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

    sessionVariables = {
      EDITOR = "nvim";
      ZVM_VI_INSERT_ESCAPE_BINDKEY = "jj"; # zsh-vi-mode escape key
    };

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    initContent = ''
      # programs.zoxide init option wasn't working
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';
  };
}
