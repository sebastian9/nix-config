_: {
  programs.nixvim.plugins = {
    lualine = {
      enable = true;
      settings = {
        globalstatus = true;
        sections.lualine_c = [
          {
            __unkeyed-1 = "filename";
            file_status = true;
            path = 4; # 4: Filename and parent dir, with tilde as the home directory
          }
        ];
      };
    };
  };
}
