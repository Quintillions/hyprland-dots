# WALPURGISNACHT: HEXENWALD — system side: fonts, Hyprlock (with PAM) and the desktop packages.
{ config, lib, pkgs, ... }:
let
  hasIosevka = pkgs.nerd-fonts ? iosevka-term-slab;

  # IM Fell fonts: drop the files into assets/fonts/ (see README.txt there).
  localFonts = pkgs.runCommand "hexenwald-local-fonts" { } ''
    mkdir -p $out/share/fonts/truetype
    cp -r ${../assets/fonts}/. $out/share/fonts/truetype/
    rm -f $out/share/fonts/truetype/README.txt
  '';
in
{
  fonts.packages =
    lib.optional hasIosevka pkgs.nerd-fonts.iosevka-term-slab
    ++ [ pkgs.noto-fonts localFonts ]            # Noto Sans Runic lives in noto-fonts
    ++ lib.optional (pkgs ? junicode) pkgs.junicode;

  warnings = lib.optional (!hasIosevka)
    "hexenwald: nerd-fonts.iosevka-term-slab not found in this nixpkgs; the terminal falls back to another font.";

  # Enables hyprlock and its PAM service (needed to unlock).
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    mako
    rofi            # if your nixpkgs still splits Wayland support out, use rofi-wayland instead
    eww
    jq
    libnotify
    playerctl
    networkmanagerapplet   # nm-connection-editor, opened from the Waybar network module
  ];
}
