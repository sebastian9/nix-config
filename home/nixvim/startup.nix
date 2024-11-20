{lib, ...}: {
  programs.nixvim = {
    plugins = {
      auto-session = {
        enable = true;
        autoSave.enabled = true;
        autoRestore.enabled = true;
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
