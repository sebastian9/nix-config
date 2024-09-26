{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  users.users."nuc".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSDMWTX3nZyps9CfmKZV29WW9Dvwms8GXjkACiCT/jc seb@dell"
  ];
  programs.ssh.startAgent = true;
}
