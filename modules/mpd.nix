{config, pkgs, ...}:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/quin/Music";
    playlistDirectory = "/home/quin/Playlist";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };

  services.mpd-mpris.enable = true;

  programs.rmpc = {
    enable = true;
  };
}