{ pkgs, config, lib, linkConfig, modPath, inputs, copier, system, ... }@args:
let
  mkLink = linkConfig config;
  ts = pkgs.tree-sitter.builtGrammars;
  confRoot = "${modPath.user}/copier";
in {
  home.packages = [ copier.defaultPackage.${system} ];

  # Hack referencing pipx-installed version of copier until I can somehow by
  # some miracle make it an actual working package
  programs.fish.functions.cop =
    "~/.local/bin/copier ${confRoot}/templates/$argv[1] $argv[2]";
}
