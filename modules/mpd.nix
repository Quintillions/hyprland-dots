{config, pkgs, ...}:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/quin/Music";
  };
}