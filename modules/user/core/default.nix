{ config, pkgs, libs, ... }: {
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs.bash = {
    bashrcExtra = ''
      alias lg="lazygit"
      alias pandoc="pandoc --pdf-engine=lualatex"
      export PATH=$PATH:~/.npm/bin
    '';
  };

  home.packages = with pkgs; [
    unzip
    ripgrep
    gcc
    iosevka
    nodejs
    python3Full
    pandoc
    lazygit
    texlive.combined.scheme-medium
    corefonts
    vistafonts
    (callPackage ../../../custom/nonicons-ttf { })
    # (callPackage ../../../custom/apple-otf { })
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.sessionVariables = { TERM = "xterm-256color"; };
}
