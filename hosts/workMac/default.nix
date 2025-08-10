{
  user,
  inputs,
  ...
}: {
  users.users.${user}.home = "/Users/${user}";

  imports = [
    ../../common/fonts.nix
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  system = {
    primaryUser = user;
    defaults.NSGlobalDomain.InitialKeyRepeat = 15;
    # Set Git commit hash for darwin-version.
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
