{user, ...}: {
  users.users.${user} = {
    isNormalUser = true;
    description = "default user";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };
}
