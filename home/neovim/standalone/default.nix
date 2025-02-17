{pkgs, ...}: {
  imports = [
    ./keymaps.nix
    ./startup.nix
    ./options.nix
    ../common/plugins/language_utils
    ../common/plugins/language_specific
    ../common/plugins/cloak.nix
    ../common/plugins/debugger.nix
    ../common/plugins/harpoon.nix
    ../common/plugins/lualine.nix
    ../common/plugins/mini.nix
    ../common/plugins/telescope.nix
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    # colorscheme = "midnight";
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

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
      # Telescope & Harpoon
      harpoon.enableTelescope = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      # color theme
      midnight-nvim
      # navigate panes and windows with ctrl+jhkl
      vim-tmux-navigator
    ];
  };
}
