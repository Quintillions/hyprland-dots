{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./fonts.nix
    ./hypr.nix 
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  services.getty.autologinUser = "quin";

  # Timezone
  time.timeZone = "Asia/Manila";

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
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  xdg.mime.enable = true;
  security.polkit.enable = true;

  environment = {
    sessionVariables = {
      STEAM_RUNTIME = "1";
      SDL_VIDEODRIVER = "wayland,x11";
      MESA_GL_VERSION_OVERRIDE = "4.6";

    };

    systemPackages = with pkgs; [
      # ─────────────────────────────
      # 🧰 Utilities
      # ─────────────────────────────
      vim
      wget
      git
      light
      brightnessctl
      iproute2
      parted
      gcc
      plymouth
      power-profiles-daemon
      hwdata
      seatd
      kitty
      quickshell

      # ─────────────────────────────
      # 🖥️ Graphics & Display Stack
      # ─────────────────────────────
      ffmpeg

      # ─────────────────────────────
      # 🧩 Wayland / X / Rendering Libraries
      # ─────────────────────────────
      wayland
      wayland-protocols
      libdrm
      libinput
      libxkbcommon
      libdisplay-info
      libliftoff
      pixman
      glibc
      meson
      ninja
      pcre2
    ];
  };

  users = {
    users.quin = {
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "networkmanager" "input" "video" "power" ];
      packages = with pkgs; [ tree ];
    };
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}








