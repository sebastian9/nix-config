{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    kitty
    git
    fzf
    nnn # terminal file manager

    # utilities
    wget
    curl
    xclip
    busybox
    gcc
  ];

  nixpkgs.config.allowUnfree = true;
}
