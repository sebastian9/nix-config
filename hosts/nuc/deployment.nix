{
  host,
  user,
  ...
} : {
  lollypops.deployment = {
    # Where on the remote the configuration (system flake) is placed
    config-dir = "~/nixos-config/";

    deploy-method = "copy";

    # SSH connection parameters
    ssh.host = host;
    ssh.user = user;
    ssh.command = "ssh";

    # sudo options
    sudo.enable = true;
    sudo.command = "sudo";
  };
}
