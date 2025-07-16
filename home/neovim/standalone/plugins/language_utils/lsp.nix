_: {
  programs.nixvim.plugins = {
    lsp.enable = true;
    lsp-format.enable = false;
    lspsaga = {
      enable = true;
      hover.openCmd = "!open -A firefox";
      outline = {
        # winWidth = 50;
        autoClose = true;
      };
    };
  };
}
