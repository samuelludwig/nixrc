{ pkgs, config, lib, modPath, linkConfig, inputs, ... }:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/kitty";
  #nixGL = (pkgs.callPackage inputs.nixGL { });
in {
  #programs.kitty = {
  #  enable = true;
  #  package = pkgs.writeShellScriptBin "kitty" (''
  #    #!/bin/sh

  #    ${nixGL}/bin/nixGL ${pkgs.kitty}/bin/kitty "$@" 
  #  '');
  #};
  xdg.configFile."kitty/kitty.conf".source = mkLink.to "${confRoot}/kitty.conf";
}
