{pkgs, ...}: {
  imports = [
    ./startup.nix
    ./keymaps.nix
    ./plugins/cloak.nix
    ./plugins/cmp.nix
    ./plugins/formatting.nix
    ./plugins/harpoon.nix
    ./plugins/lint.nix
    ./plugins/lsp.nix
    ./plugins/lualine.nix
    ./plugins/mini.nix
    ./plugins/telescope.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorscheme = "midnight";

    opts = {
      # You can search for any of these using Telescope help_tags
      mouse = "a";
      relativenumber = true;
      number = true;
      ignorecase = true;
      smartcase = true; # Don't ignore case with capitals
      scrolloff = 8;
      hlsearch = true;
      incsearch = true;
      autoindent = true;
      smartindent = true;
      expandtab = true;
      tabstop = 4;
      softtabstop = 4;
      undofile = true;
      wrap = true;
      swapfile = false;
      backup = false;
      updatetime = 50;
      virtualedit = "block"; # nice visual-block
    };

    plugins = {
      # AST syntax highlighting
      treesitter.enable = true;
      # Debugger
      dap.enable = true;
      # Go to the lastplace a file was edited
      lastplace.enable = true;
      # Git tree like undo tracking
      undotree.enable = true;
      # Nix language support
      nix.enable = true;
      # Track todo comments :TodoTelescope
      todo-comments.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      # color theme
      midnight-nvim
      # navigate panes and windows with ctrl+jhkl
      vim-tmux-navigator
    ];
  };
}
