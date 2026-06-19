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

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "qs -c lock ipc call lock lock";
        before_sleep_cmd = "qs -c lock ipc call lock lock";
        after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl set 10%";
          on-resume = "brightnessctl set 100%";
        }

        {
          timeout = 450;
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
        }

        {
          timeout = 600;
          on-timeout = "qs -c lock ipc call lock lock";
        }

        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
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
