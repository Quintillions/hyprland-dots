{ config, pkgs, ... }:
{
  environment = {
      systemPackages = with pkgs; [
        # ─────────────────────────────
        # 🧰 Utilities
        # ─────────────────────────────
        vim
        wget
        git
        brightnessctl
        iproute2
        parted
        gcc
        hwdata
        seatd
        rocmPackages.rocm-smi
        libimobiledevice
        ifuse

        # ─────────────────────────────
        # 🧩 Wayland / X / Rendering Libraries
        # ─────────────────────────────
        wayland
        wayland-protocols
        libdrm
        libinput
        libxkbcommon
        libdisplay-info
        glibc
      
        pavucontrol
        gsmartcontrol
        smartmontools
      
        


        # ─────────────────────────────

        cloudflare-warp
        flatpak
        vesktop
        jdk21_headless
      ];
    };
}