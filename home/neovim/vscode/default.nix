{pkgs, ...}: {
  imports = [
    ./keymaps.nix
    ./options.nix
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
      # Nix language support
      nix.enable = true;
      # Lazy loading of plugins
      lazy.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      # navigate panes and windows with ctrl+jhkl
      vim-tmux-navigator
    ];
  };
}
