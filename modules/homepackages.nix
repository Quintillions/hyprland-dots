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



    # Coding
    # jetbrains.pycharm-community
    # vscode
    # netbeans


  ];
}

