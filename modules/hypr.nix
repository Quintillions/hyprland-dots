{ config, inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "qs -c lock ipc call lock lock";
        before_sleep_cmd = "qs -c lock ipc call lock lock";
        after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl set 10%";
          on-resume = "brightnessctl set 100%";
        }

        {
          timeout = 450;
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
        }

        {
          timeout = 600;
          on-timeout = "qs -c lock ipc call lock lock";
        }

        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
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
    grim
    slurp
    
  ];
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}
