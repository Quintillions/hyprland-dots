{config, pkgs, ...}:

{
    imports = [ 
        ./modules/homepackages.nix
        ./modules/terminal.nix
    ];
    
    home.file.".config/hypr".source = ./config/hypr;
    home.file.".config/quickshell".source = ./config/quickshell;
    home.file.".config/wallust".source = ./config/wallust;
    home.file.".config/fastfetch".source = ./config/fastfetch;


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





