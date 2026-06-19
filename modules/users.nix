{ config, pkgs, ... }:
{
  users = {
    users.quin = {
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "networkmanager" "input" "video" "power" ];
      packages = with pkgs; [ tree ];
    };
  };
  nix.gc = {
    automatic = true;
    dates = "weekly"; # or any schedule you prefer
    options = "--max-old-generations 5"; # Keep 5 old + 1 current = 6 total
  };
}