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
      let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
      let NERDTreeWinPos = "right"
      map <leader>f :Files<CR>
      map <leader>b :Buffers<CR>
      map <leader>c :Commands<CR>
      map <leader>m :Marks<CR>
      map <leader>h :Helptags<CR>
      map <leader>/ :Rg<CR>
      map <leader><Tab> :b#<CR>
      map <leader>p :r !wl-paste<CR>
      map <leader>n :NERDTreeToggle<CR>
    '';
  };
}
