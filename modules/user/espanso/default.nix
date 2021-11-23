{ pkgs, config, lib, linkConfig, modPath, meta, inputs, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/espanso/config";
in {
  #home.packages = with pkgs; [ espanso ];

  #
  # Config files
  #
  xdg.configFile."espanso".source = mkLink.to "${confRoot}/";
}
