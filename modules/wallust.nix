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
          template = "hypr-colors.lua";
        };

        "alacritty-colors.toml" = {
          target = "~/.cache/wallust/alacritty-colors.toml";
          template = "alacritty-colors.toml";
        };

        "fastfetch.config.jsonc" = {
          target = "~/.config/fastfetch/config.jsonc";
          template = "fastfetch.config.jsonc";
        };


      };
    };



}