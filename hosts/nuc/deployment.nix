{
  lollypops.deployment = {
    # Where on the remote the configuration (system flake) is placed
    config-dir = "~/nixos-config/";

    deploy-method = "copy";

    # SSH connection parameters
    ssh.host = "nuc";
    ssh.user = "nuc";
    ssh.command = "ssh";

    # sudo options
    sudo.enable = true;
    sudo.command = "sudo";
  };
}
