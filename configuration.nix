{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./modules/bootloader.nix
    ./modules/networking.nix
    ./modules/hypr.nix 
    ./modules/fonts.nix
    ./modules/locales.nix
    ./modules/syspackages.nix
    ./modules/users.nix
    ./modules/spotify.nix
    ./modules/hexenwald.nix
    # ./modules/sddm.nix

  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;
  
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  
  };

  hardware.uinput.enable = true;

  
	hardware.graphics = {
  		enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
        libva
        libva-utils
      ];
	};

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  
  services = {
    # openssh = {
    #   enable = true;
    #   settings = {
    #     PermitRootLogin = "no"; # "yes" or "prohibit-password" if needed
    #     PasswordAuthentication = true; # Enforce key-based auth
    #     KbdInteractiveAuthentication = true;
    #     AllowUsers = [ "quin" ];
    #  };
    # };

    gvfs.enable = true; # nemo mtp for android devices
    usbmuxd.enable = true; # nemo ftp for ios devices
    udisks2.enable = true;
	  dbus.enable = true;
    power-profiles-daemon.enable = lib.mkDefault true;
    # xserver.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    # Login prompt at boot (no autologin).
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "gameoflife";
      };

    };

    cloudflare-warp.enable = true;

    flatpak.enable = true;


  };


programs.obs-studio = {
  enable = true;
  enableVirtualCamera = true;
  plugins = with pkgs.obs-studio-plugins; [
    wlrobs
    obs-vaapi
    obs-backgroundremoval
    obs-pipewire-audio-capture
  ];
};
programs.appimage.enable = true;
programs.appimage.binfmt = true;
programs.appimage.package = pkgs.appimage-run.override 
{
  extraPkgs = pkgs: 
  [
    pkgs.icu
    pkgs.libxcrypt-legacy
    pkgs.python312
    pkgs.python312Packages.torch
    pkgs.pipewire
    pkgs.pulseaudio
    pkgs.libpulseaudio   # Required for PulseAudio API/client hooks
    pkgs.alsa-lib        # Required for direct sound layer detection
  ]; 
};



  xdg.mime.enable = true;
  
  security.polkit.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}
