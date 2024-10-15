{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fzf
    fd
  ];
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      fzf-vim
      catppuccin-vim
      vim-lastplace
      vim-nix
      vim-addon-nix
      YouCompleteMe
    ];
    settings = {
      ignorecase = true;
      relativenumber = true;
      number = true;
    };
    extraConfig = ''
      set mouse=a
      let mapleader=" "
      let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
      map <leader>ff :Files<CR>
      map <leader>fb :Buffers<CR>
      map <leader>fc :Commands<CR>
      map <leader>fm :Marks<CR>
      map <leader>fh :Helptags<CR>
      map <leader>/ :Rg<CR>
      map <leader><Tab> :b#<CR>
      map <leader>e :Ex<CR>
    '';
  };
}
