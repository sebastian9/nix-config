{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      fzf-vim
      zoxide-vim
      vim-nix
    ];
    settings = {
      ignorecase = true;
      relativenumber = true;
      number = true;
    };
    extraConfig = ''
      set mouse=a
      let mapleader=" "
      map <leader>pf :Files<CR>
      map <leader>bb :Buffers<CR>
      map <leader>s :Rg<CR>
      map <leader><Tab> :b#
    '';
  };
}
