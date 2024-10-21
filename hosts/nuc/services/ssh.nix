{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  users.users."nuc".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSDMWTX3nZyps9CfmKZV29WW9Dvwms8GXjkACiCT/jc seb@dell"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMgk4wsFGNrncm8qWRnqGy9QYrUogq4JMn0FGBnnQhH slopezsanchez@LUSHQF0X7F3GW"
  ];
  programs.ssh.startAgent = true;
}
