{ pkgs, config, lib, linkConfig, modPath, meta, inputs, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.lang}/janet/config";
in {
  home.packages = with pkgs; [ janet ];

  #
  # Config files
  #
  #xdg.configFile."".source = mkLink.to "${confRoot}/";
}
