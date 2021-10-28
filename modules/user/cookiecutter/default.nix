{ config, pkgs, libs, linkConfig, modPath, inputs, system, ... }:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/cookiecutter";
in {
  home.packages = with pkgs; [ cookiecutter ];
  programs.fish.shellAliases = { cook = "cookiecutter"; };
  xdg.configHome.".cookiecutters".source = mkLink.to "${confRoot}/cookiecutters";
  #xdg.homeFile.".cookiecutters".source = mkLink.to "${modPath.user}/cookiecutter/cookiecutters";
}
