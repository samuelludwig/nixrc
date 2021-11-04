{ config, pkgs, libs, linkConfig, modPath, inputs, system, ... }:
let
  mkLink = linkConfig config;
  confRoot = "${modPath.user}/core";
in {
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Nix needs
    cachix

    # Tools
    patchelf
    unzip
    ripgrep
    sc-im # Terminal-based spreadsheets
    pandoc
    xplr # File explorer TUI

    # Fonts
    texlive.combined.scheme-medium
    iosevka
    corefonts
    vistafonts
    (callPackage ../../../custom/nonicons-ttf { })
    # (callPackage ../../../custom/apple-otf { })
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.sessionVariables = { TERM = "xterm-256color"; };
  #xdg.configFile."nix/nix.conf".source = mkLink.to "${confRoot}/nix.conf";
}
