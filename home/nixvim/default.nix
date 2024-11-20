{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.programs.nixvim;
in {
  imports = [
    # ./startup.nix
    ./keymaps.nix
    ./options.nix
    ./plugins/language_utils
    ./plugins/language_specific
    ./plugins/cloak.nix
    ./plugins/debugger.nix
    ./plugins/harpoon.nix
    ./plugins/lualine.nix
    ./plugins/mini.nix
    ./plugins/telescope.nix
  ];

  options.programs.nixvim = {
    vscode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to strip the neovim configuration for vscode neovim to work";
    };
  };

  config = {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        # navigate panes and windows with ctrl+jhkl
        vim-tmux-navigator
      ];

      plugins = {
        # TODO - Add github copilot
        # Go to the lastplace a file was edited
        lastplace.enable = true;
        # Git tree like undo tracking
        undotree.enable = true;
        # Nix language support
        nix.enable = true;
        # Track todo comments :TodoTelescope
        todo-comments.enable = true;
        # Lazy loading of plugins
        lazy.enable = true;
      };

      colorschemes = {
        catppuccin = {
          enable = true;
          settings.flavour = "mocha";
        };
      };
    };
  };
}
