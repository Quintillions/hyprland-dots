{config, pkgs, ...}:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  services.getty.autologinUser = "quin";
}