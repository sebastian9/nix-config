_: {
  programs.nixvim.plugins = {
    lualine = {
      enable = true;
      globalstatus = true;
      sections.lualine_c = [
        {
          name = "filename";
          extraConfig = {
            file_status = true;
            path = 4; # 4: Filename and parent dir, with tilde as the home directory
          };
        }
      ];
    };
  };
}
