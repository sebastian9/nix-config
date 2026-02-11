{lib, ...}: {
  programs.git = {
    enable = true;
    userName = lib.mkDefault "sebastian9";
    userEmail = lib.mkDefault "sebastianls0228@gmail.com";
    lfs.enable = true;
    aliases = {
      unstage = "reset HEAD --";
    };
    ignores = [
      "*~"
      ".claude"
      ".DS_Store"
      "CLAUDE.md"
      ".vscode/"
      ".idea/"
      "secrets.json"
    ];
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        hyperlinks = true;
        navigate = true;
      };
    };
  };
}
