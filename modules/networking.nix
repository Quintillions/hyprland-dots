{config, pkgs, ...}:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    
    firewall = {
      enable = true;
      # allowedTCPPorts = [ 9090 ];
    };
  };

  services.getty.autologinUser = "quin";
}