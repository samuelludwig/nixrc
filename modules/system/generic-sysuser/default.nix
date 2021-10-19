{ config, pkgs, ... }:
{
  # Don't worry, its not real...
  users.users.generic = {
    #isNormalUser = true;
    #isSystemUser = false;
    #initialPassword = "########";
    #extraGroups = [ "wheel" "docker" "networkmanager" "video" ];
  };
}
