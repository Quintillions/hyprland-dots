{ config, pkgs, inputs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;

    package = pkgs.everforest-cursors;
    name = "Everforest-Cursors";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.everforest-gtk-theme;
      name = "Everforest-Dark";
    };

    gtk4.theme = config.gtk.theme;

    iconTheme = {
      package = pkgs.everforest-gtk-theme;
      name = "Everforest-Dark";
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    kdePackages.qt6ct
  ];
}