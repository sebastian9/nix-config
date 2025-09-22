_: {
  programs.nixvim.plugins.gitblame = {
    enable = true;
    settings = {
      date_format = "%x";
    };
  };
}
