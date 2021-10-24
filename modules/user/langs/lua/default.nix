{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  #lua = pkgs.<luaVer>;
  #luarocks = pkgs.<luarocksVer>;
  mkLink = linkConfig config;
in {
  #home.packages = [ lua luarocks ];

  #
  # Link .ini files
  #
  #xdg.configFile."<>".source =
  #  mkLink.to "${modPath.user}/langs/lua/<filepath>";
}
