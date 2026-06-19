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

  ];


  # XWayland support

  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      proton-ge-bin
    ];
  };

	hardware.graphics = {
  		enable = true;
      enable32Bit = true;
	};


  services = {
	dbus.enable = true;
    xserver.displayManager.lightdm.enable = false;
    power-profiles-daemon.enable = lib.mkDefault true;
    xserver.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  xdg.mime.enable = true;
  
  security.polkit.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}








