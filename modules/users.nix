{ config, pkgs, ... }:
{
  users = {
    users.quin = {
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "networkmanager" "input" "video" "power" ];
      packages = with pkgs; [ tree ];
    };
  };
}