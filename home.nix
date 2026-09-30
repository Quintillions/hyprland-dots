{config, pkgs, ...}:

{
    imports = [ 
        ./modules/homepackages.nix
        ./modules/terminal.nix
        ./modules/gtk.nix
        ./modules/wallust.nix
        ./modules/mpd.nix
        # ./modules/mime.nix
    ];
    
    home.file.".config/hypr".source = ./config/hypr;
    home.file.".config/quickshell".source = ./config/quickshell;
    home.file.".config/wallust/templates".source = ./config/wallust/templates;

    home.username = "quin";
    home.homeDirectory = "/home/quin";
    home.stateVersion = "25.05";
    programs.bash = {
        enable = true;
        shellAliases = {
            wtf = "echo 'what the fish' ";
        };
    };
    home.packages = [
        pkgs.pulseaudio
        pkgs.playerctl

    ];

}





