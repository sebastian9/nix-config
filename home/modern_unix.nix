{pkgs, ...}: {
  # https://github.com/ibraheemdev/modern-unix
  home.packages = with pkgs;
    [
      # A cat clone with syntax highlighting and Git integration.
      bat
      # The next gen file listing command. Backwards compatible with ls.
      lsd
      # A viewer for git and diff output
      delta
      # A new way to see and navigate directory trees
      broot
      # A simple, fast and user-friendly alternative to find.
      fd
      # An extremely fast alternative to grep that respects your gitignore
      ripgrep
      # A general purpose command-line fuzzy finder.
      fzf
      # Fly through your shell history. Great Scott!
      mcfly
      # sed for JSON data.
      jq
      # An intuitive find & replace CLI (sed alternative).
      sd
      # A modern replacement for ps written in Rust.
      procs
      # A modern, user-friendly command-line HTTP client for the API era.
      httpie
      # The power of curl, the ease of use of httpie.
      curlie
      # A smarter cd command inspired by z
      zoxide
      # simple terminal UI for git commands
      lazygit
    ]
    ++ (with pkgs; [
      # Some others I've found
      # yaml processor https://github.com/mikefarah/yq
      yq-go
      # tldr rust client
      # https://github.com/tldr-pages/tldr
      tlrc
      # command line file manager
      lf
    ]);
  # Configurations
  programs = {
    git.delta = {
      enable = true;
    };
    broot.settings.modal = true;
  };
}
