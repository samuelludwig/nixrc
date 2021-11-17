{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/gitea/configs";
in {
  home.packages = with pkgs; [ gitea tea ];

  #
  # Config files
  #
  xdg.configFile."tea".source = mkLink.to "${confRoot}/tea";
}
