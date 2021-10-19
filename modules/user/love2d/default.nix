{ pkgs, config, lib, ...}:
{
  home.packages = with pkgs; [
    love_11
  ];
}
