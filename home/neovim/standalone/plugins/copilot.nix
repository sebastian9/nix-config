_: {
  programs.nixvim.plugins = {
    copilot-lua = {
      enable = true;
      settings = {
        panel = { enable = false; };
        suggestion = { enable = false; };
      };
    };
    copilot-cmp = {
      enable = true;
    };
    copilot-chat = {
      enable = true;
    };
  };
}
