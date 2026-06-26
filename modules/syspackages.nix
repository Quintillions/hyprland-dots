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
        light
        brightnessctl
        iproute2
        parted
        gcc
        power-profiles-daemon
        hwdata
        seatd
        rocmPackages.rocm-smi

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
      
        


        # ─────────────────────────────

        cloudflare-warp
        flatpak
      ];
    };
}