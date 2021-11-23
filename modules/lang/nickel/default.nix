{ pkgs, config, lib, linkConfig, modPath, meta, inputs, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.lang}/nickel/config";
in {
  home.packages = with pkgs; [ nickel ];

  #
  # Config files
  #
  #xdg.configFile."".source = mkLink.to "${confRoot}/";
}
