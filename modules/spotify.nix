{config, inputs, pkgs, ...}:

{
  imports = [inputs.spicetify-nix.nixosModules.default];

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
      enable = true;

      theme = spicePkgs.themes.comfy;
      colorScheme = "Everforest";
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        spicyLyrics
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        allOfArtist
        powerBar
     ];
  };



}