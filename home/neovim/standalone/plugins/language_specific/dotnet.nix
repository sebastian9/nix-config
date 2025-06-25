_: {
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        csharp_ls.enable = true;
      };
    };
  };
}
