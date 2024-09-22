{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    kitty
    git
    fzf

    # utilities
    wget
    curl
    xclip
    busybox
    gcc
  ];

  nixpkgs.config.allowUnfree = true;
}
