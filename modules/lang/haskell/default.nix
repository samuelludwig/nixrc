{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  mkLink = linkConfig config;
in {
  home.packages = with pkgs; [ cabal2nix cabal-install ghc stack ];

  #
  # Link config files
  #
  #xdg.configFile."haskell/.conf".source =
  #  mkLink.to "${modPath.user}/langs/haskell/.conf";
}
