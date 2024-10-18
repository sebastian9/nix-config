{
  inputs,
  system,
  ...
}: {
  virtualisation.docker = {
    enable = true;
  };
  environment.systemPackages = [
    inputs.compose2nix.packages.${system}.default
  ];
}
