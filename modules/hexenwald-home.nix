# WALPURGISNACHT: HEXENWALD — Home Manager side: link the config trees.
# Waybar is linked per file so ~/.config/waybar stays a real directory; wallust writes accent.css there.
{ config, lib, pkgs, ... }:
{
  xdg.configFile = {
    "waybar/config.jsonc".source = ../config/waybar/config.jsonc;
    "waybar/style.css".source    = ../config/waybar/style.css;
    "waybar/assets".source       = ../config/waybar/assets;
    "mako/config".source         = ../config/mako/config;
    "rofi".source                = ../config/rofi;
    "eww".source                 = ../config/eww;
    "hexenwald".source           = ../config/hexenwald;
  };
}
