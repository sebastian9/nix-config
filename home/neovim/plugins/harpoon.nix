{...}: {
  programs.nixvim.plugins = {
    harpoon = {
      enable = true;
      enableTelescope = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "<leader>'";
        toggleQuickMenu = "<leader>he";
        navFile = {
          "1" = "'j";
          "2" = "'k";
          "3" = "'l";
          "4" = "'m";
        };
      };
    };
  };
}
