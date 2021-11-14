{ pkgs, config, lib, linkConfig, modPath, inputs, copier-pkgs-preview, system
, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/copier";
  # Use normal `pkgs` once jonringer's pull request gets accepted into nixpkgs
  copier = (import copier-pkgs-preview { inherit system; }).copier;
in {
  # Blessed be jonringer and damned be python
  home.packages = [ copier ];

  # Ergonomic usage similar to cookiecutter
  programs.fish.functions.cop =
    "copier ${confRoot}/templates/$argv[1] $argv[2]";
}
