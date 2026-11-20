{config, pkgs, ...}:
{
  programs.wallust = {
    enable = true;

    settings = {
      backend = "resized";
      color_space = "lab";
      palette = "softdark";
      fallback_generator = "complementary";

      # Accents only: the Hexenwald palette itself is fixed in the theme files.
      templates = {

        "waybar-accent.css" = {
          target = "~/.config/waybar/accent.css";
          template = "waybar-accent.css";
        };

        "alacritty-accent.toml" = {
          target = "~/.cache/wallust/alacritty-accent.toml";
          template = "alacritty-accent.toml";
        };

        "fastfetch.jsonc" = {
          target = "~/.config/fastfetch/config.jsonc";
          template = "fastfetch.jsonc";
        };

      };
    };
  };
}
