{config, pkgs, ...}:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.kde.dolphin.desktop";
      "text/plain" = "code.desktop";               # vscode
      "application/pdf" = "org.kde.okular.desktop"; # or whatever PDF viewer you have
      "image/png" = "org.kde.gwenview.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
      "video/mp4" = "vlc.desktop";
      "audio/mpeg" = "vlc.desktop";
    };
  };
}