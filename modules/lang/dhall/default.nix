{ pkgs, config, lib, linkConfig, modPath, meta, inputs, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.lang}/dhall/config";
in {
  home.packages = with pkgs; [
    dhall
    dhall-nix
    dhall-json
    dhall-bash
    dhallPackages.Prelude
  ];

  #
  # Config files
  #
  #xdg.configFile."".source = mkLink.to "${confRoot}/";
}
