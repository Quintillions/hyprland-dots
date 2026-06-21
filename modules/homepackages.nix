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
    obs-studio
    openrgb
    vscode

    # Coding
    # jetbrains.pycharm-community
    # vscode
    # netbeans


  ];
}

