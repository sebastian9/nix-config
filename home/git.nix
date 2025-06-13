{lib, ...}: {
  programs.git = {
    enable = true;
    userName = lib.mkDefault "sebastian9";
    userEmail = lib.mkDefault "sebastianls0228@gmail.com";
    aliases = {
      unstage = "reset HEAD --";
    };
  };
}
