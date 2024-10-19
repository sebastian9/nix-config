_: {
  programs.nixvim.plugins.cloak = {
    enable = true;
    settings = {
      cloak_character = "*";
      highlight_group = "Comment";
      patterns = [
        {
          file_pattern = [
            ".env*"
            "fuze.env*"
          ];
          cloak_pattern = "=.+";
        }
      ];
    };
  };
}
