{lib, ...}: {
  programs.git = {
    enable = true;
    userName = lib.mkDefault "sebastian9";
    userEmail = lib.mkDefault "sebastianls0228@gmail.com";
    lfs.enable = true;
    aliases = {
      unstage = "reset HEAD --";
    };
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
