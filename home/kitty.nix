{lib, ...}:
{
  programs.kitty = {
    enable = true;
    font.size = lib.mkDefault 16;
    font.name = "DejaVu Sans";
  };
}
