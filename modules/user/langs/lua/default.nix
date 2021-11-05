{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  luajit = pkgs.luajit;
  mkLink = linkConfig config;
in {
  home.packages = with pkgs // pkgs.luajitPackages; [
    luajit
    luarocks-nix
    busted
    fennel
  ];

  #
  # Link .ini files
  #
  #xdg.configFile."<>".source =
  #  mkLink.to "${modPath.user}/langs/lua/<filepath>";
}
