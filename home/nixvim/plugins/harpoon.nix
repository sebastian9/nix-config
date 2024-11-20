{config, ...}: let
  cfg = config.programs.nixvim;
in {
  programs.nixvim.plugins = {
    harpoon = {
      enable = true;
      enableTelescope = !cfg.vscode;
      keymapsSilent = true;
    };
  };
}
