{
  users.users.nuc = {
    isNormalUser = true;
    description = "default user";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}
