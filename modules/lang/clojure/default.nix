{ pkgs, config, lib, linkConfig, modPath, meta, inputs, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.lang}/clojure/config";
in {
  home.packages = with pkgs; [ babashka ];

  #
  # Config files
  #
  #xdg.configFile."".source = mkLink.to "${confRoot}/";
}
