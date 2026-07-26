{config, pkgs, ...}:
{
  programs.wallust = {
    enable = true;

    settings = {
      backend = "kmeans";
      color_space = "lab";
      palette = "softdark";

      templates = {

      "hypr-colors.lua" = {
        target = "~/.cache/wallust/hypr-colors.lua";
        text = 
          ''
            return {
              active = "{{color4}}",
              inactive = "{{background}}",
            }
          '';
      };

      "alacritty-colors.toml" = {
        target = "~/.cache/wallust/alacritty-colors.toml";
        text = 
          ''
            [colors.primary]
            background = "{{background}}"
            foreground = "{{foreground}}"

            [colors.cursor]
            text = "{{background}}"
            cursor = "{{cursor}}"

            [colors.selection]
            text = "{{foreground}}"
            background = "{{color8}}"

            [colors.normal]
            black = "{{color0}}"
            red = "{{color1}}"
            green = "{{color2}}"
            yellow = "{{color3}}"
            blue = "{{color4}}"
            magenta = "{{color5}}"
            cyan = "{{color6}}"
            white = "{{color7}}"

            [colors.bright]
            black = "{{color8}}"
            red = "{{color9}}"
            green = "{{color10}}"
            yellow = "{{color11}}"
            blue = "{{color12}}"
            magenta = "{{color13}}"
            cyan = "{{color14}}"
            white = "{{color15}}"
          '';
      };

      "fastfetch.config.jsonc" = {
        target = "~/.config/fastfetch/config.jsonc";

        text=
          ''
            {
              "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
              "logo": {
                "type": "file",
                "source": "~/hyprland-dots/config/fastfetch/logo.txt",
                "color": {
                  "1": "38;2;224;86;59",
                  "2": "38;2;239;106;79",
                  "3": "38;2;51;55;63",
                  "4": "38;2;63;69;80",
                  "5": "38;2;139;145;156",
                  "6": "38;2;91;102;120",
                  "7": "38;2;196;204;218"
                },
                "padding": { "top": 1, "left": 2, "right": 6 }
              },
              "display": {
                "separator": "  ",
                "color": {
                  "keys": "38;2;{{color3 | red}};{{color3 | green}};{{color3 | blue}}"
                },
                "key": { "width": 10 }
              },
              "modules": [
                "break",
                { "type": "custom", "format": "\u001b[38;2;{{color8 | red}};{{color8 | green}};{{color8 | blue}}m── system ──────────────" },
                { "type": "os", "key": "  os", "format": "{pretty-name}" },
                { "type": "kernel", "key": "  kernel", "format": "{release}" },
                { "type": "uptime", "key": "  up" },
                { "type": "packages", "key": " 󰏖 pkgs", "format": "{all}" },
                "break",
                { "type": "custom", "format": "\u001b[38;2;{{color8 | red}};{{color8 | green}};{{color8 | blue}}m── rice ────────────────" },
                { "type": "wm", "key": "  wm", "format": "{pretty-name}" },
                { "type": "shell", "key": "  shell", "format": "{exe-name}" },
                { "type": "terminal", "key": "  term", "format": "{pretty-name}" },
                { "type": "custom", "key": " 󰂜 bar", "format": "pill (quickshell)" },
                { "type": "custom", "key": " 󰄀 shot", "format": "grim + slurp + satty" },
                { "type": "custom", "key": "  font", "format": "JetBrains Mono Nerd" },
                "break",
                { "type": "colors", "symbol": "block", "block": { "width": 3, "range": [2, 7] }, "paddingLeft": 2 },
                "break"
              ]
            }

          '';
      };


    };
    };


    
  };
}