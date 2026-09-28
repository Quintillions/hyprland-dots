{ config, inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    config = {
      common = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    wireplumber
    libva
    intel-media-driver


    hyprpaper
    hyprpicker
    hypridle
    jq
    imagemagick
    grim
    slurp
    satty
    cliphist
    ddcutil
    everforest-gtk-theme
    adwaita-qt
    adwaita-qt6
    libnotify

    nemo
    nomacs
    zathura
    linux-wallpaperengine
    wl-clipboard
    gvfs
    haskellPackages.gio
    spotdl
  ];
  services.hypridle.enable = true;
  services.udev.extraRules = ''
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
'';

  
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

}
