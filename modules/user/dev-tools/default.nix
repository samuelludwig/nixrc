{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    lazygit
    gcc
  ];
  programs.fish.shellAliases.gs = "lazygit";
}
