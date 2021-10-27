{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  mkLink = linkConfig config;
in {
  home.packages = [ pkgs.unison-ucm ];

  #
  # Link conf files
  #
  #xdg.configFile."<>".source =
  #  mkLink.to "${modPath.user}/langs/unison/<filepath>";
}
