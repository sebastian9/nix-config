{
  pkgs,
  ...
}: {
  home = {
    file.".config/feel/feel-repl.sc" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/camunda/feel-scala/master/feel-repl.sc";
        sha256 = "sha256-rQL8JfNBCaNYOhqFGfGYKcwMsnspPY9MfM/tcJagkWk=";
      };
    };
  };
  programs = {
    zsh = {
      sessionVariables = {
        GITHUB_USER = "slopezsanchez";
      };
      initContent = ''
        # programs.zoxide init option wasn't working
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)";
        source ~/teleport-ssh-config/teleport-functions;
      '';
    };
  };
}
