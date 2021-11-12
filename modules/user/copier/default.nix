{ pkgs, config, lib, linkConfig, modPath, inputs, copier, system, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/copier";
in {
  # Blessed be jonringer and damned be python
  #home.packages = [ pkgs.copier ];

  # Hack referencing pipx-installed version of copier until jonringer's pull
  # request is accepted into nixpkgs
  programs.fish.functions.cop =
    "~/.local/bin/copier ${confRoot}/templates/$argv[1] $argv[2]";

  #programs.fish.functions.cop =
  #  "copier ${confRoot}/templates/$argv[1] $argv[2]";
}
