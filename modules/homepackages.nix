{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    spicetify-cli
        
    # dev
    python3
    lua
    lazygit
    feh
    

    calibre
    vscode
    vlc
    deadlock-mod-manager

    # Communication
    teams-for-linux
    zoom-us
    prismlauncher
    chromium
    mpd

  ];

}

