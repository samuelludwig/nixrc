{ pkgs, config, lib, ...}:
{
  home.packages = with pkgs; [
    android-tools
    android-studio
  ];
}
