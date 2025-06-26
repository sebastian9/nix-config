{lib, ...}: {
  programs.nixvim = {
    plugins = {
      auto-session = {
        settings = {
          enable = true;
          autoSave = true;
          autoRestore = true;
        };
      };

      mini = {
        enable = true;
        modules = {
          starter = {
            header = lib.concatLines [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
            items = [
              {
                name = "Find File";
                action = "Telescope find_files follow=true no_ignore=true hidden=true";
                section = "";
              }
              {
                name = "Recent File";
                action = "Telescope oldfiles";
                section = "";
              }
              {
                name = "Live Grep";
                action = "Telescope live_grep";
                section = "";
              }
              {
                name = "Quit";
                action = "qa";
                section = "";
              }
            ];
          };
        };
      };
    };
  };
}
