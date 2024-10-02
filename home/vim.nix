{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      fzf-vim
      zoxide-vim
      nerdtree
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
      map <leader>f :Files<CR>
      map <leader>b :Buffers<CR>
      map <leader>/ :Rg<CR>
      map <leader><Tab> :b#<CR>
      map <leader>p :r !wl-paste<CR>
      map <leader>n :NERDTreeToggle<CR>
    '';
  };
}
