{config, pkgs, ...}:

{
    imports = [ 
        ./modules/homepackages.nix
        ./modules/terminal.nix
        ./modules/gtk.nix
        ./modules/wallust.nix
        ./modules/mpd.nix
        ./modules/hexenwald-home.nix
        # ./modules/mime.nix
    ];
    
    home.file.".config/hypr".source = ./config/hypr;
    home.file.".config/wallust/templates".source = ./config/wallust/templates;

    home.username = "quin";
    home.homeDirectory = "/home/quin";
    home.stateVersion = "25.05";
    programs.bash = {
        enable = true;
        shellAliases = {
            wtf = "hyprctl --instance 0 eval 'hl.clear_crashed_lockscreen()'";
        };
    };
    home.packages = [
        pkgs.pulseaudio
        pkgs.playerctl

    ];

}
