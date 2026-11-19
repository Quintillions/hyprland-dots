{config, pkgs, ...}:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 9090 ]; # 8080 file server for web, 9090 for kindle, 22 for ftp
    };
  };

  services.getty.autologinUser = "quin";
}