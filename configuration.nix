{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./fonts.nix
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
  programs.xwayland.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # FOR screen recording and portals
	hardware.graphics = {
  		enable = true;
      driSupport = true;
      driSupport32Bit = true;
  		extraPackages = with pkgs; [
    		libva        # Core VA-API library
    		intel-media-driver  # Intel GPU VA-API driver
        mesa
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
        intel-compute-runtime
  		];
	};


  services = {
	dbus.enable = true;
    xserver.displayManager.lightdm.enable = false;
    upower.enable = lib.mkDefault true;
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
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      QT_QPA_PLATFORM = "wayland";  

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








