{
  user,
  ...
}: {
  home = {
    homeDirectory = "/home/users/${user}";
    sessionPath = [
      "$HOME/.pyenv/bin"
      "$HOME/.nvm"
    ];
  };
}
