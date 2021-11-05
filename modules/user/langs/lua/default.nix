{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  luajit = pkgs.luajit;
  mkLink = linkConfig config;
in {
  home.packages = with pkgs.luajitPackages; [
    lua
    luajit
    luarocks-nix
    busted
  ];

  #
  # Link .ini files
  #
  #xdg.configFile."<>".source =
  #  mkLink.to "${modPath.user}/langs/lua/<filepath>";
}
