{ pkgs, config, lib, linkConfig, modPath, inputs, copier, system, ... }@args:
let
  mkLink = linkConfig config;
  ts = pkgs.tree-sitter.builtGrammars;
  confRoot = "${modPath.user}/copier";
in { home.packages = [ copier.defaultPackage.${system} ]; }
