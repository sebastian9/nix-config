{pkgs, ...}: {
  imports = [
    ./startup.nix
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
    ./plugins/treesitter.nix
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
    };

    extraPlugins = with pkgs.vimPlugins; [
      # color theme
      midnight-nvim
      # navigate panes and windows with ctrl+jhkl
      vim-tmux-navigator
    ];
  };
}
