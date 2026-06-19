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
}