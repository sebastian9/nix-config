{...}: {
  programs.nixvim.plugins = {
    harpoon = {
      enable = true;
      enableTelescope = true;
      keymapsSilent = true;
      keymaps = {
        # m is the native set mark key
        # ' is  the native mark motion
        # j is the first mark
        # h is too far away from '
        addFile = "mj";
        toggleQuickMenu = "<leader>me";
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
