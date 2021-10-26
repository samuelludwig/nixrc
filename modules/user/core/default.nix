{ config, pkgs, libs, ... }: {
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Tools
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
}
