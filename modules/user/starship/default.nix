{ pkgs, config, lib, inputs, linkConfig, modPath, ... }: 
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/starship";
in {
  home.packages = [ pkgs.fasd ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.configFile."starship.toml".source = mkLink.to "${confRoot}/starship.toml"; 
}
