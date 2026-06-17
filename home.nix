{config, pkgs,inputs, ...}:

{
    imports = [ 
        ./chatnwhatnot.nix
        ./alacritty.nix
    ];
    
    home.file.".config/hypr".source = ./config/hypr;
    home.file.".config/quickshell".source = ./config/quickshell;


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
        inputs.quickshell.packages.${pkgs.system}.default

    ];
}





