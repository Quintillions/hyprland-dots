{ config, inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    hyprpaper
    wallust
    hyprpicker
    hypridle
    jq
    inputs.quickshell.packages.${pkgs.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    xdg-desktop-

    
  ];
}
