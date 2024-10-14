{ pkgs, ... }:
{
  # tldr rust client
  # https://github.com/tldr-pages/tldr
  home.packages = with pkgs; [ tlrc ];
  # nav is a command line interactive cheatsheet
  # https://github.com/denisidoro/navi
  programs.navi = {
    enable = true;
  };
}
