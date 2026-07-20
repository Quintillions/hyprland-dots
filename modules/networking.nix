{config, pkgs, ...}:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    
    firewall = {
      enable = true;
      # allowedTCPPorts = [ 9090 ];
    };
  };

  services.getty.autologinUser = "quin";
}