{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    # git tools
    lazygit

    # building/compiling needs
    gcc
    patchelf

    # file-watchers
    entr
    watchman
    python39Packages.watchdog
  ];
  programs.fish.shellAliases.gs = "lazygit";
}
