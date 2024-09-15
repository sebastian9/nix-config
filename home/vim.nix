{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    settings = {
      ignorecase = true;
      relativenumber = true;
      number = true;
    };
    extraConfig = ''
      set mouse=a
    '';
  };
}
