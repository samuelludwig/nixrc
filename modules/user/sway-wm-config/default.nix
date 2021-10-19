{ pkgs, config, lib, ... }: {
  home.file.".config/sway/config".source = ./config;
}
