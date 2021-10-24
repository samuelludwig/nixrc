{ pkgs, config, lib, linkConfig, modPath, inputs, ... }@args:
let
  elixir = pkgs.elixir;
  mkLink = linkConfig config;
in {
  home.packages = [ elixir ];

  #
  # Link conf files
  #
  #xdg.configFile."<>".source =
  #  mkLink.to "${modPath.user}/langs/elixir/<filepath>";
}
