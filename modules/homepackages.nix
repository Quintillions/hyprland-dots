{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    spicetify-cli
    discord
        
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


  ];

}

