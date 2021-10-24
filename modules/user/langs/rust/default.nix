{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  rust = pkgs.rust-bin.stable.latest.default;
  mkLink = linkConfig config;
in {
  home.packages = [ rust ];

  #
  # Link conf files
  #
  #xdg.configFile."<>".source =
  #  mkLink.to "${modPath.user}/langs/rust/<filepath>";
}
