{ lib, pkgs, ... }:
{
   home.packages = with pkgs; [
    # cli
    fastfetch
    yt-dlp
    ffmpeg-full
    zip
    xz
    unzip
    p7zip
    glow
    curl
    bluez
    rar
    gnutar
    cava
    btop
    nitch
    gparted
    
  ];
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = lib.mkOrder 1500 "
      fastfetch
    ";
    
    shellAliases = {
      nrsif = "sudo nixos-rebuild switch --impure --flake .";
      warp-on = "warp-cli connect";
      warp-off = "warp-cli disconnect";
    };

    oh-my-zsh = {
      enable = true;
      theme = "xiong-chiamiov-plus";
      plugins = [
        "sudo"
      ];
    }; 
  };

  programs.fastfetch = {
    enable = true;
    
    settings = {

    };
  };


  programs.alacritty = {
    enable = true;
    # theme = "catppuccin_macchiato";
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
               
        };

        size = 12;
      };
      window = {
        padding = {
          x = 8;
          y = 8;
        }; 
        decorations = "none";
        dynamic_title = true;
        opacity = 0.5;
      };


      terminal = {
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = [ "-l" ]; # "-l" = login shell (optional, but good practice)
        };
      };

  
    };

  };
}
