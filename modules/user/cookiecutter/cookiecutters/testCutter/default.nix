{ config, pkgs, libs, linkConfig, modPath, inputs, system, ... }:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/{{cookiecutter.module_name}}";
in {
  home.packages = with pkgs; [ ];
  #xdg.configFile."{{cookiecutter.xdg_config_file}}".source = mkLink.to "${confRoot}/{{cookiecutter.config_location}}";
}
