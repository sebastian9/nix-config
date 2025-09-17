_: {
  programs.nixvim.plugins.project-nvim = {
    enable = true;
    settings = {
      manual_mode = false;
      detection_methods = [ "lsp" "pattern" ];
      patterns = [ ".git" ];
    };
  };
}
