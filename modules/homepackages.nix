{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    spicetify-cli
        
    # dev
    python3
    lua
    lazygit
    

    calibre
    vscode
    vlc

    # Communication
    teams-for-linux
    zoom-us
    prismlauncher
    chromium
    mpd
    rmpc

  ];

}

