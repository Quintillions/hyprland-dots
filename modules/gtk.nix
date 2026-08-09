{config, pkgs, inputs, ...}:

{
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.everforest-cursors;
    name = "Everforest-Cursors";
    size = 16;
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";

  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.everforest-gtk-theme;
      name = "Everforest-Dark-BL";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    kdePackages.qt6ct

  ];
  

}
