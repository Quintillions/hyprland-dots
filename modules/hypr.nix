{ config, inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpaper
    wallust
    hyprpicker
    hypridle
    jq
    inputs.quickshell.packages.${pkgs.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    wireplumber
    libva
    intel-media-driver

    
  ];
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}
