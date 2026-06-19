{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    vesktop
    libreoffice
    spicetify-cli
        
    # dev
    python3
    lua
    lazygit


    # system info
    btop
    fastfetch
    nitch
    gdu
    gparted

    # Coding
    # jetbrains.pycharm-community
    # vscode
    # netbeans


  ];
}

