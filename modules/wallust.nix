{config, pkgs, ...}:
{
  programs.wallust = {
    enable = true;

    settings = {
      backend = "resized";
      color_space = "lab";
      palette = "softdark";
      fallback_generator = "complementary";

        templates = {

        "hypr-colors.lua" = {
          target = "~/.cache/wallust/hypr-colors.lua";
          template = "hypr-colors.lua";
        };

        "alacritty-colors.toml" = {
          target = "~/.cache/wallust/alacritty-colors.toml";
          template = "alacritty-colors.toml";
        };

        "fastfetch.jsonc" = {
          target = "~/.config/fastfetch/config.jsonc";
          template = "fastfetch.jsonc";
        };


      };
    };
  };
}